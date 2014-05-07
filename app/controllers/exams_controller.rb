# encoding: utf-8
class ExamsController < ApplicationController
  load_and_authorize_resource

  def index
    is_bolsao = [true, false] if params[:is_bolsao].nil?
    is_bolsao = (params[:filter_by] == 'true' ? true : false) if params[:is_bolsao].present?

    @exams = Exam.where(id: ExamExecution.where(
      super_klazz_id: SuperKlazz.where(campus_id: Campus.accessible_by(current_ability).map(&:id)), 
      exam_cycle_id: ExamCycle.where(is_bolsao: is_bolsao, product_year_id: ProductYear.where(year_id: Year.last.id))
    ).map(&:exam_id).uniq)
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if @exam.save
      @exam.create_exam_executions(
        params[:exam][:campus_ids].reject! { |c| c.empty? }.map { |e| e.to_i },
        params[:exam][:product_year_ids].reject! { |c| c.empty? }.map { |e| e.to_i }
      )
      redirect_to exams_url(is_bolsao: false), notice: 'Prova criada com sucesso.'
    else
      render 'new'
    end
  end

  def update
    if @exam.update_attributes(params[:exam].except("exam_date", "campus_ids", "product_year_ids"))
      redirect_to exams_url(is_bolsao: false), notice: 'Prova atualizada com sucesso.'
    else
      render 'edit'
    end
  end

  def destroy
    @exam.destroy
    redirect_to exams_url, notice: 'Prova deletada com sucesso.'
  end

  def import
    ExamCsvImportWorker.perform_async(params[:file].tempfile.path, current_employee.email)
    redirect_to root_url, notice: "Provas importadas com sucesso."    
  end

  def result
    @existing_answers = @exam.correct_answers.present?
    if @existing_answers
      exam_execution_ids = @exam.exam_execution_ids
      @student_exams = StudentExam.where(status: StudentExam::VALID_STATUS, exam_execution_id: exam_execution_ids).includes({:card_processing => :campus}, :student)
      @subjects = @exam.exam_questions.includes(:question => {:topics => :subject}).map(&:question).map(&:topics).map(&:first).map(&:subject).group_by{|a| a}.map{|a, b| [a, b.size]}
      @has_errors = @exam.exam_executions.map(&:needs_check?).select{|a| a}.any?
    end
  end
  
  def download_result
    separator = ","
    base =
      StudentExam.where("grades is not null").where(
        status: StudentExam::VALID_STATUS,
        exam_execution_id: @exam.exam_execution_ids
      ).includes(
        student: {enrollments: :super_klazz},
        exam_execution: [:exam, { super_klazz: [:campus, product_year: [product: :product_type] ]}]
      )

    header_complement = @exam.subjects.split("+").map{|m| m.gsub(/^\s+/, '').gsub(/\s+$/, '').split("(")[0]} if @exam.correct_answers.present?
    # recalculate grades
    correct_answers = @exam.correct_answers
    number_of_questions = Hash[*@exam.exam_questions.map(&:question).map(&:topics).map(&:first).map(&:subject).map(&:code).group_by{|a| a}.map{|a,b| [a, b.size]}.flatten]
    subjects = @exam.exam_questions.map(&:question).map(&:topics).map(&:first).map(&:subject).map(&:code)

    if @exam.correct_answers.present?
      base.each do |student_exam|
        grades = Hash[*subjects.uniq.map{|a| [a,0]}.flatten]
        student_exam.exam_answer_as_string.split('').each_with_index do |answer, index|
          if correct_answers[index] == 'X' || answer == correct_answers[index]
          grades[subjects[index]] = grades[subjects[index]] + 1
          end
        end
        grades.each{ |key,value| grades[key] = (10*value.to_f / number_of_questions[key].to_f).round(2) }
        student_exam.update_column(:grades, grades.to_a.flatten.join(','))
      end    
    end

    @results = ([ (["RA", "Nome do aluno", "Unidade", "Grau", "Série", "Turma", "Código da prova", "Marcações"] + (header_complement || []) ).join(separator)] + 
      base.map do |student_exam|
        ([
          ("%06d" % (student_exam.student.try(:ra) || 0)),
          (student_exam.student.try(:name) || '').split.map(&:mb_chars).map(&:capitalize).join(' '), 
          student_exam.exam_execution.try(:super_klazz).try(:campus).try(:name) || '',
          student_exam.exam_execution.try(:super_klazz).try(:product_year).try(:product).try(:product_type).try(:name) || '',
          student_exam.exam_execution.try(:super_klazz).try(:product_year).name,
          student_exam.student.enrollments.select{|e| e.super_klazz_id == student_exam.exam_execution.super_klazz_id}.first.try(:erp_code) || '', 
          ("%05d" % (student_exam.exam_execution.exam.code || 0)),
          student_exam.string_of_answers
        ] + Hash[*(student_exam.grades || '').split(',')].values ).join(separator)
        
      end).flatten.compact.join("\r\n")


    respond_to do |format|
      format.html
      format.csv do
        response.headers['Content-Disposition'] = "attachment; filename=\"Resultados - #{@exam.name} - #{@exam.exam_product_years.first.name}.csv\""
        render text: @results.encode("ISO-8859-1", "utf-8")
      end
    end    
  end

  def download
    @results = 
      Exam.where(id: ExamExecution.where(
        exam_cycle_id: ExamCycle.where(is_bolsao: false, product_year_id: ProductYear.where(year_id: Year.last.id))
      ).map(&:exam_id)).includes(exam_executions: [:exam_cycle, super_klazz: [:campus, product_year: [:product, :year]]]).map do |exam|
        [
          exam.exam_executions.first.is_bolsao ? 1 : 0,
          exam.exam_executions.map(&:datetime).map(&:to_date).uniq.sort.join('|'),
          exam.exam_executions.map(&:super_klazz).map(&:campus).map(&:name).uniq.sort.join('|'),
          exam.exam_product_years.map(&:name).uniq.sort.join('|'),
          exam.name.split(' - ')[1..-1].join(' - '),
          exam.name.split(' - ')[0],
          exam.erp_code,
          exam.exam_full_subjects,
          exam.correct_answers
        ].join(';')
      end.flatten.compact.join("\r\n")

    respond_to do |format|
      format.html
      format.csv { render text: @results }
    end    
  end

end
