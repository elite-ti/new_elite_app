#encoding: utf-8

class ExamExecutionsController < ApplicationController
  # load_and_authorize_resource

  def index
    if params[:filter_by].nil?
      @exam_executions = ExamExecution.where(
        super_klazz_id: SuperKlazz.where(campus_id: Campus.accessible_by(current_ability).map(&:id), product_year_id: ProductYear.where(year_id: Year.last.id)),
        exam_cycle_id: ExamCycle.where(is_bolsao: false).map(&:id)
      ).includes([super_klazz: [:campus, {product_year: :product}], exam_cycle: [], card_processings: []])

      # @exam_executions = ExamExecution.where(super_klazz_id: SuperKlazz.where(campus_id: Campus.accessible_by(current_ability).map(&:id)), exam_cycle_id: ExamCycle.where(product_year_id: ProductYear.where(year_id: Year.last.id )))
      @filter_by = ''
    elsif params[:filter_by] == 'is_bolsao'
      date = ExamExecution.where(super_klazz_id: SuperKlazz.where(campus_id: Campus.accessible_by(current_ability).map(&:id)), exam_cycle_id: ExamCycle.where(is_bolsao: true).map(&:id)).map(&:datetime).map(&:to_date).uniq.max
      @exam_executions = ExamExecution.where(super_klazz_id: SuperKlazz.where(campus_id: Campus.accessible_by(current_ability).map(&:id)), exam_cycle_id: ExamCycle.where(is_bolsao: true).map(&:id), datetime: date.beginning_of_day..date.end_of_day)
      @filter_by = ' - Bolsão'
    elsif params[:filter_by].include?'is_bolsao_'
      campuz = Campus.find(translate(params[:filter_by].split('_')[2]))
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
      campuz = Campus.find(translate(params[:filter_by].split('_')[2]))
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
      campuz = Campus.find(translate(params[:filter_by].split('_')[1]))
      super_klazz_ids = SuperKlazz.where(product_year_id: ProductYear.school_products.map(&:id), campus_id: campuz.id).map(&:id)
      exam_cycle_ids = ExamCycle.where(is_bolsao: false).map(&:id)
      @exam_executions = ExamExecution.where(super_klazz_id: super_klazz_ids, exam_cycle_id: exam_cycle_ids).includes([super_klazz: [:campus, {product_year: :product}], exam_cycle: [], card_processings: []])
      @filter_by = ' - Colégio - ' + campuz.name
    else
      render :file => 'public/404.html', :status => :not_found, :layout => false      
    end
  end

  def translate input
    translations = {
      'bangu' => '1',
      'bg' => '1',
      'b' => '1',
      'cg1' => '2',
      'cgi' => '2',
      'cg2' => '3',
      'cgii' => '3',
      'ig' => '4',
      'ilha' => '4',
      'mad1' => '5',
      'm1' => '5',
      'mad2' => '6',
      'm2' => '6',
      'mad3' => '7',
      'm3' => '7',
      'norteshopping' => '8',
      'ns' => '8',
      'novaiguacu' => '9',
      'ni' => '9',
      'sg1' => '10',
      'sgi' => '10',
      'sg2' => '11',
      'sgii' => '11',
      'taquara' => '12',
      't' => '12',
      'tq' => '12',
      'r9' => '12',
      'tijuca' => '13',
      'tj' => '13',
      'valqueire' => '14',
      'v' => '14',
      'vv' => '14',
      'val' => '14'
    }
    if translations.keys.include? input
      translations[input]
    else
      input
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

  def cards
    @exam_execution = ExamExecution.find(params[:exam_execution_id])
    @student_exams = (@exam_execution.card_processings.map(&:student_exams).flatten + @exam_execution.student_exams).uniq
    @translations = {'Being processed' => 'Em processamento', 'Error' => 'Erro', 'Student not found' => 'Aluno não encontrado', 'Exam not found' => 'Prova não encontrada', 'Invalid answers' => 'Respostas inválidas', 'Valid' => 'Válido', 'Repeated student' => 'Aluno Repetido'}
  end

  def result
    @exam_execution = ExamExecution.where(id: params[:exam_execution_id].to_i).includes(:exam => {:exam_questions => {:question => [:options, {:topics => :subject}]}}).first
    @existing_answers = @exam_execution.exam.correct_answers.present?
    if @existing_answers
      @student_exams = @exam_execution.student_exams.where(status: StudentExam::VALID_STATUS).includes({:card_processing => :campus}, :student, :exam_answers)
      @has_errors = @exam_execution.needs_check?
      @subjects = @exam_execution.exam.exam_questions.sort_by(&:number).map(&:question).map(&:topics).map(&:first).map(&:subject).uniq

      subject_questions = @exam_execution.exam.exam_questions.map{|eq| [eq.number, eq.question.topics.first.subject.name]}.inject(Hash.new(0)){|h,v| ((h[v[1]] != 0) ? h[v[1]] << v[0] : h[v[1]] = [v[0]]); h}
      correct_answers = @exam_execution.exam.exam_questions.sort_by(&:number).map(&:question).map{|q| q.options.select{|o| o.correct}.map(&:letter)}

      @results = @student_exams.map do |student_exam|
        {
          'RA' => ("%07d" % (student_exam.student.ra || student_exam.student.number || 0)),
          'NAME' => student_exam.student.name.split.map(&:mb_chars).map(&:capitalize).join(' '),
          'PATH' => student_exam_path(student_exam),
          'CAMPUS' => student_exam.campus.name,
          'ID' => student_exam.id
        }.merge(
            if student_exam.exam_answer_as_string.present?
              @subjects.inject(Hash.new(0)){|h, v| h[v.code] = (student_exam.exam_answer_as_string || '').split('').each_with_index.select{|answer, index| subject_questions[v.name].include?(index+1) && (correct_answers[index].size == 5 || correct_answers[index].include?(answer))}.size; h}
            else
              @subjects.inject(Hash.new(0)){|h, v| h[v.code] = student_exam.exam_answers.select{|exam_answer| subject_questions[v.name].include?(exam_answer.exam_question.number) && (correct_answers[exam_answer.exam_question.number - 1].size == 5 || correct_answers[exam_answer.exam_question.number - 1].include?(exam_answer.answer))}.size; h}
            end
          )#.merge({'GRADE' => student_exam.exam_answers.select{|exam_answer| correct_answers[exam_answer.exam_question.number - 1].include?(exam_answer.answer)}.size})
      end
    end
    
  end

  def scanned
    @exam_execution = ExamExecution.find(params[:exam_execution_id])
    card_processing_ids = '(' + (CardProcessing.where(exam_execution_id: params[:exam_execution_id]).map(&:id) + [-1]).join(', ') + ')'
    @results =
      (StudentExam.where("exam_execution_id = #{params[:exam_execution_id]} or (card_processing_id in #{card_processing_ids} and exam_execution_id is null)"
      ).includes([:student, {exam_execution: :exam}]).map do |student_exam|
        [
          # student
          if student_exam.student && student_exam.student.ra
            ("%06d" % (student_exam.student.try(:ra) || 0))
          else
            student_exam.student_number || 'WWWWWW'
          end,
          # exam
          if student_exam.exam_execution && student_exam.exam_execution.exam && student_exam.exam_execution.exam.code
            ("%05d" % (student_exam.exam_execution.try(:exam).try(:code) || 0))
          else
            student_exam.exam_code || 'WWWWW'
          end,
          (student_exam.string_of_answers || 'Z'*100).gsub('Z','X').gsub('W','Z').gsub('X','W') || ('Z' * 100)
        ].join()
    end.compact).join("\r\n")

    respond_to do |format|
      format.html
      format.csv do
        response.headers['Content-Disposition'] = "attachment; filename=\"cards_data_#{@exam_execution.full_name}.txt\""
        render text: @results.encode("ISO-8859-1", "utf-8")
      end
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