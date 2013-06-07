# encoding: UTF-8
class ExamResultsController < ApplicationController
  # load_and_authorize_resource
  def index
    respond_to do |format|
      format.html do 
        @lists = [
          ['Pré-Vestibular', ['Pré-Vestibular Manhã', '3ª Série + Pré-Vestibular Manhã', 'Pré-Vestibular Biomédicas', '3ª Série + Pré-Vestibular Biomédicas', 'Pré-Vestibular Noite']],
          ['ESPCEX', ['ESPCEX', '3ª Série + ESPCEX']],
          ['AFA/EAAr/EFOMM', ['AFA/EAAr/EFOMM']],
          ['AFA/EN/EFOMM', ['AFA/EN/EFOMM', '3ª Série + AFA/EN/EFOMM']],
          ['AFA/ESPCEX', ['AFA/ESPCEX', '3ª Série + AFA/ESPCEX']],
          ['2ª Série Militar', ['2ª Série Militar']],
          ['1ª Série Militar', ['1ª Série Militar']],
          ['9º Ano Militar', ['CN/EPCAR', '9º Ano Militar']],
          ['9º Ano Forte', ['9º Ano Forte']],
          ['IME-ITA', ['IME-ITA']]
        ]
        all_campuses = Campus.new
        all_campuses.id = 0
        all_campuses.name = 'Sistema Elite de Ensino'
        @accessible_campuses = [all_campuses]
        @accessible_campuses += Campus.accessible_by(current_ability) 
        @possible_dates = @accessible_campuses.map(&:super_klazzes).flatten.map(&:exam_executions).flatten.map(&:datetime).map(&:to_date).uniq.sort!
      end
      format.json do
        exam_result = params[:exam_result]
        p 'Call JSON Rendering'
        render json: exam_results_hash(exam_result[:campus_id], exam_result[:product_year_id], exam_result[:date]).to_json 
      end
    end
  end

private
  def exam_results_hash(campus_id, product_year_id, date)
    p 'INSIDE FUNCTION exam_results_hash'
    @lists = [
      ['Pré-Vestibular', ['Pré-Vestibular Manhã', '3ª Série + Pré-Vestibular Manhã', 'Pré-Vestibular Biomédicas', '3ª Série + Pré-Vestibular Biomédicas', 'Pré-Vestibular Noite']],
      ['ESPCEX', ['ESPCEX', '3ª Série + ESPCEX']],
      ['AFA/EAAr/EFOMM', ['AFA/EAAr/EFOMM']],
      ['AFA/EN/EFOMM', ['AFA/EN/EFOMM', '3ª Série + AFA/EN/EFOMM']],
      ['AFA/ESPCEX', ['AFA/ESPCEX', '3ª Série + AFA/ESPCEX']],
      ['2ª Série Militar', ['2ª Série Militar']],
      ['1ª Série Militar', ['1ª Série Militar']],
      ['9º Ano Militar', ['CN/EPCAR', '9º Ano Militar']],
      ['9º Ano Forte', ['9º Ano Forte']],
      ['IME-ITA', ['IME-ITA']]
    ]
    
    product_year_ids = @lists.select{|p| p[0] == product_year_id}.first[1].map{|product_year_name| ProductYear.find_by_name(product_year_name + ' - 2013')}.map(&:id)
    campus_id = Campus.all.map(&:id) if campus_id.to_i == 0 # All campuses
    super_klazzes_ids = SuperKlazz.where(
      product_year_id: product_year_ids,
      campus_id: campus_id).map(&:id)
    date = Date.parse(date)

    date_interval = (date.beginning_of_day)..(date.end_of_day)
    exam_executions = ExamExecution.where(datetime: date_interval, super_klazz_id: super_klazzes_ids)
    student_exams = StudentExam.where(exam_execution_id: exam_executions.map(&:id)).includes(:student, {:card_processing => :campus}, {:exam_answers => {:exam_question => {:question => [:options, {:topics => :subject}]}}})

    return [{'RA' => '', 'NAME' => '', 'GRADE' => ''}] if student_exams.size == 0
    subjects = student_exams.first.exam_answers.map(&:exam_question).map(&:question).map(&:topics).map(&:first).map(&:subject).uniq
    subject_questions = student_exams.first.exam_answers.map(&:exam_question).map{|eq| [eq.number, eq.question.topics.first.subject.name]}.inject(Hash.new(0)){|h,v| ((h[v[1]] != 0) ? h[v[1]] << v[0] : h[v[1]] = []); h}
    correct_answers = student_exams.first.exam_answers.map(&:exam_question).map(&:question).map{|q| q.options.select{|o| o.correct}.map(&:letter)}

    student_exams.map do |student_exam|
       {'RA' => ("%07d" % student_exam.student.ra), 'NAME' => student_exam.student.name.upcase, 'CAMPUS' => student_exam.campus.name.upcase}.merge(
          subjects.inject(Hash.new(0)){|h, v| h[v.code] = student_exam.exam_answers.select{|exam_answer| subject_questions[v.name].include?(exam_answer.exam_question.number) && correct_answers[exam_answer.exam_question.number - 1].include?(exam_answer.answer)}.size; h}
        ).merge({'GRADE' => student_exam.exam_answers.select{|exam_answer| correct_answers[exam_answer.exam_question.number - 1].include?(exam_answer.answer)}.size})
    end
  end  
end
