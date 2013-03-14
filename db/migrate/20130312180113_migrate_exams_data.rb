# encoding: UTF-8
class MigrateExamsData < ActiveRecord::Migration
  def up
  	ActiveRecord::Base.transaction do 
  		add_column :exam_days, :super_exam_id, :integer
      add_column :student_exams, :exam_day_id, :integer

      questions_without_topic = Question.all.select do |q| q.topics.empty? end
      ciclo_zero_exams = questions_without_topic.map(&:exams).flatten.uniq

      {
        'LÍNGUA PORTUGUESA' => 1..25, 
        'MATEMÁTICA' => 26..50
      }.each_pair do |subject_name, question_numbers|
        ciclo_zero_exams.each do |exam|
          exam.exam_questions.order('number').where(number: question_numbers).each do |exam_question|
            port_question = exam_question.question
            port_question.update_attribute :topic_ids, [Subject.find_by_name(subject_name).topics.first.id]
          end
        end
      end

  		old_exams = Exam.all
  		old_exams.each do |old_exam|
        super_exam = SuperExam.create!
        old_exam.exam_days.each do |exam_day|
          exam_day.update_attribute :super_exam_id, super_exam.id 
        end

  			h = get_subject_answers_hash_from(old_exam)
  			h.each_pair do |subject, correct_answers|
          super_exam.exams.create!(
  					subject_id: subject.id, 
  					correct_answers: correct_answers,
  					options_per_question: old_exam.options_per_question)
  			end
  		end	

  		old_exams.map(&:destroy)
  		remove_column :exams, :name
      remove_column :exam_days, :exam_id
      remove_column :student_exams, :exam_execution_id
  	end
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end

  def get_subject_answers_hash_from(exam)
		questions = exam.exam_questions.order('number').map(&:question)

    h = {}
    questions.each do |question|
      letter = question.correct_options.first.letter

      if h[question.topics.first.subject] == nil
        h[question.topics.first.subject] = letter
      else
        h[question.topics.first.subject] = h[question.topics.first.subject] + letter
      end
    end
    h
  end
end
