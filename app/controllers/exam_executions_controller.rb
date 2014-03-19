#encoding: utf-8

class ExamExecutionsController < ApplicationController
  # load_and_authorize_resource
  include ApplicationHelper

  def index
    if params[:filter_by].nil?
      @exam_executions = SuperKlazz.where(campus_id: Campus.accessible_by(current_ability).map(&:id)).map(&:exam_executions).flatten.uniq
      @filter_by = ''
    elsif params[:filter_by] == 'is_bolsao'
      date = ExamExecution.where(super_klazz_id: SuperKlazz.where(campus_id: Campus.accessible_by(current_ability).map(&:id)), exam_cycle_id: ExamCycle.where(is_bolsao: true).map(&:id)).map(&:datetime).map(&:to_date).uniq.max
      @exam_executions = ExamExecution.where(super_klazz_id: SuperKlazz.where(campus_id: Campus.accessible_by(current_ability).map(&:id)), exam_cycle_id: ExamCycle.where(is_bolsao: true).map(&:id), datetime: date.beginning_of_day..date.end_of_day)
      @filter_by = ' - Bolsão'
    elsif params[:filter_by].include?'is_bolsao_'
      campuz = Campus.find(translate_campus_by_name(params[:filter_by].split('_')[2]))
      @exam_executions = ExamExecution.all.select{|ee| ee.is_bolsao && campuz == ee.super_klazz.campus}
      @filter_by = ' - Bolsão - ' + campuz.name
    elsif params[:filter_by] == 'free_course'
      # @exam_executions = SuperKlazz.where(product_year_id: ProductYear.free_course_products.map(&:id), campus_id: Campus.accessible_by(current_ability).map(&:id)).map(&:exam_executions).flatten.uniq.select{|exam_execution| !exam_execution.is_bolsao}
      super_klazz_ids = SuperKlazz.where(product_year_id: ProductYear.free_course_products.map(&:id), campus_id: Campus.accessible_by(current_ability).map(&:id)).map(&:id)
      exam_cycle_ids = ExamCycle.where(is_bolsao: false).map(&:id)
      @exam_executions = ExamExecution.where(super_klazz_id: super_klazz_ids, exam_cycle_id: exam_cycle_ids).includes([super_klazz: [:campus, {product_year: :product}], exam_cycle: [], card_processings: []])
      @filter_by = ' - Curso'
    elsif params[:filter_by].include?'free_course_'
      # @exam_executions = SuperKlazz.where(product_year_id: ProductYear.free_course_products.map(&:id), campus_id: campuz.id).map(&:exam_executions).flatten.uniq.select{|exam_execution| !exam_execution.is_bolsao}
      campuz = Campus.find(translate_campus_by_name(params[:filter_by].split('_')[2]))
      super_klazz_ids = SuperKlazz.where(product_year_id: ProductYear.free_course_products.map(&:id), campus_id: campuz.id).map(&:id)
      exam_cycle_ids = ExamCycle.where(is_bolsao: false).map(&:id)
      @exam_executions = ExamExecution.where(super_klazz_id: super_klazz_ids, exam_cycle_id: exam_cycle_ids).includes([super_klazz: [:campus, {product_year: :product}], exam_cycle: [], card_processings: []])
      @filter_by = ' - Curso - '+ campuz.name
    elsif params[:filter_by] == 'school'
      # @exam_executions = SuperKlazz.where(product_year_id: ProductYear.school_products.map(&:id), campus_id: Campus.accessible_by(current_ability).map(&:id)).map(&:exam_executions).flatten.uniq.select{|exam_execution| !exam_execution.is_bolsao}
      super_klazz_ids = SuperKlazz.where(product_year_id: ProductYear.school_products.map(&:id), campus_id: Campus.accessible_by(current_ability).map(&:id)).map(&:id)
      exam_cycle_ids = ExamCycle.where(is_bolsao: false).map(&:id)      
      @exam_executions = ExamExecution.where(super_klazz_id: super_klazz_ids, exam_cycle_id: exam_cycle_ids).includes([super_klazz: [:campus, {product_year: :product}], exam_cycle: [], card_processings: []])
      @filter_by = ' - Colégio'
    elsif params[:filter_by].include?'school_'
      # @exam_executions = SuperKlazz.where(product_year_id: ProductYear.school_products.map(&:id), campus_id: campuz.id).map(&:exam_executions).flatten.uniq.select{|exam_execution| !exam_execution.is_bolsao}
      campuz = Campus.find(translate_campus_by_name(params[:filter_by].split('_')[1]))
      super_klazz_ids = SuperKlazz.where(product_year_id: ProductYear.school_products.map(&:id), campus_id: campuz.id).map(&:id)
      exam_cycle_ids = ExamCycle.where(is_bolsao: false).map(&:id)
      @exam_executions = ExamExecution.where(super_klazz_id: super_klazz_ids, exam_cycle_id: exam_cycle_ids).includes([super_klazz: [:campus, {product_year: :product}], exam_cycle: [], card_processings: []])
      @filter_by = ' - Colégio - ' + campuz.name
    else
      render :file => 'public/404.html', :status => :not_found, :layout => false      
    end
  end

  def attendance
    respond_to do |format|
      format.pdf do
        pdf = AttendanceListPrawn.new(params[:exam_execution_id])
        if !params[:exam_execution_id].nil?
          filename = 'ListaPresença - ' + ExamExecution.find(params[:exam_execution_id]).super_klazz.name + '.pdf'
        else
          filename = 'ListaPresença_Branco.pdf'
        end
        send_data pdf.render, filename: filename, type: "application/pdf", disposition: "inline"
      end
    end    
  end

  def new
    @exam = Exam.new
    @exam_execution = ExamExecution.new
    @accessible_campuses = []
    @accessible_campuses += Campus.accessible_by(current_ability) 
  end

  def create
    subject_check = 0
    if params[:exam_execution][:exam][:mini_exams_attributes].nil? 
      redirect_to new_exam_execution_path, notice: 'Clique em "Adicionar Matéria"'
    else
      order = 1
      correct_answers_arr = []
      subject = []
      subject_ids = []
      params[:exam_execution][:exam][:mini_exams_attributes].each do |key|
        if key[1]["_destroy"].include? "false"
          correct_answers_arr << key[1]["correct_answers"].upcase
          subject_ids << key[1]["subject_id"]
          subject << Subject.where(id: key[1]["subject_id"]).first.code + "(#{key[1]["correct_answers"].size.to_s})"
          subject_check+=1
        end
      end
      if subject_check < 1
        redirect_to new_exam_execution_path, notice: 'Adicione pelo menos 1 Matéria'
      else
        if params[:exam_execution][:exam][:is_bolsao].to_i > 0
          product_years = ProductYear.where(name: Product.where(id: params[:exam_execution][:product_year_ids][1..-1]).map{|a| a.name+" - 2014"})
          is_bolsao = true
        else
          product_years = ProductYear.where(name: Product.where(id: params[:exam_execution][:product_year_ids][1..-1]).map{|a| a.name+" - 2013"})
          is_bolsao = false
        end
        update_check = 0
        shift_string = params[:exam_execution][:exam][:shift]
        datetime = params[:exam_execution][:datetime]
        cycle_name = params[:exam_execution][:exam_cycle]
        exam_name = params[:exam_execution][:exam][:name]
        correct_answers = correct_answers_arr*""
        correct_answers_per_subject = Hash[*subject_ids.zip(correct_answers_arr).flatten]
        campus_ids = params[:exam_execution][:campus_ids][1..-1]
        if campus_ids.include? "16"
          campuses = Campus.all
        else
          campuses = Campus.where(id: campus_ids)
        end

        exam = Exam.where(name: cycle_name + " - " + exam_name, correct_answers: correct_answers).first_or_create!(
          name: cycle_name + " - " + exam_name, 
          correct_answers: correct_answers, 
          options_per_question: 5)

        correct_answers_per_subject.each_pair do |subject_id, correct_answers|
          mini_exam = MiniExam.where(exam_id: exam.id, subject_id: subject_id, correct_answers: correct_answers).first_or_create!(
            exam_id: exam.id, 
            subject_id: subject_id, 
            correct_answers: correct_answers,
            options_per_question: 5,
            order: order)
          order += 1
        end

        product_years.each do |product_year|
          exam_cycle = ExamCycle.where(
            name: cycle_name + " - " + product_year.product.name + shift_string + subject*" + ").first_or_create!(
            is_bolsao: is_bolsao, product_year_id: product_year.id)

          campuses.each do |campus|
            super_klazz = SuperKlazz.where(product_year_id: product_year.id, campus_id: campus.id).first
            next if super_klazz.nil?
            
            if campus_ids.include? "16"
              exam_execution = ExamExecution.create!(
                exam_cycle_id: exam_cycle.id, 
                super_klazz_id: super_klazz.id,
                datetime: datetime,
                exam_id: exam.id)
            else
              exam_execution = ExamExecution.where(exam_cycle_id: exam_cycle.id, super_klazz_id: super_klazz.id).first_or_create!(
                exam_cycle_id: exam_cycle.id, 
                super_klazz_id: super_klazz.id, 
                datetime: datetime, 
                exam_id: exam.id)
              exam_execution.update_attribute :exam_id, exam.id
              update_check =+ 1              
            end
          end
        end

        if update_check < 1
          redirect_to new_exam_execution_path, notice: 'Prova criada com sucesso!'
        else
          redirect_to new_exam_execution_path, notice: 'Prova criada para unidades (' + campuses.map(&:name)*", " + ")"
        end
      end
    end
  end

  def cards
    @exam_execution = ExamExecution.find(params[:exam_execution_id])
    @student_exams = (@exam_execution.card_processings.map(&:student_exams).flatten + @exam_execution.student_exams).uniq
    @translations = {'Being processed' => 'Em processamento', 'Error' => 'Erro', 'Student not found' => 'Aluno não encontrado', 'Exam not found' => 'Prova não encontrada', 'Invalid answers' => 'Respostas inválidas', 'Valid' => 'Válido', 'Repeated student' => 'Aluno Repetido'}
  end

  def result
    @exam_execution = ExamExecution.where(id: params[:exam_execution_id].to_i).includes(:exam => {:exam_questions => {:question => [:options, {:topics => :subject}]}}).first
    @student_exams = @exam_execution.student_exams.where(status: StudentExam::VALID_STATUS).includes({:card_processing => :campus}, :student, :exam_answers)
    @has_errors = @exam_execution.needs_check?
    @subjects = @exam_execution.exam.exam_questions.map(&:question).map(&:topics).map(&:first).map(&:subject).uniq

    subject_questions = @exam_execution.exam.exam_questions.map{|eq| [eq.number, eq.question.topics.first.subject.name]}.inject(Hash.new(0)){|h,v| ((h[v[1]] != 0) ? h[v[1]] << v[0] : h[v[1]] = [v[0]]); h}
    correct_answers = @exam_execution.exam.exam_questions.map(&:question).map{|q| q.options.select{|o| o.correct}.map(&:letter)}

    @results = @student_exams.map do |student_exam|
      {
        'RA' => ("%07d" % student_exam.student.ra),
        'NAME' => student_exam.student.name.split.map(&:mb_chars).map(&:capitalize).join(' '),
        'CAMPUS' => student_exam.campus.name,
        'ID' => student_exam.id
      }.merge(
          @subjects.inject(Hash.new(0)){|h, v| h[v.code] = student_exam.exam_answers.select{|exam_answer| subject_questions[v.name].include?(exam_answer.exam_question.number) && (correct_answers[exam_answer.exam_question.number - 1].size == 5 || correct_answers[exam_answer.exam_question.number - 1].include?(exam_answer.answer))}.size; h}
        )#.merge({'GRADE' => student_exam.exam_answers.select{|exam_answer| correct_answers[exam_answer.exam_question.number - 1].include?(exam_answer.answer)}.size})
    end
  end

  def consolidated_by_cicle
    if(params[:exam_cycle_id].nil?)
      render :file => 'public/404.html', :status => :not_found, :layout => false
    else
      params[:exam_cycle_id]
    end
  end
end