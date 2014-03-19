class Exam < ActiveRecord::Base  
  attr_accessible :name, :options_per_question, :correct_answers

  has_many :exam_questions, dependent: :destroy, inverse_of: :exam
  has_many :questions, through: :exam_questions
  has_many :mini_exams, dependent: :destroy
  has_many :exam_executions, dependent: :destroy
  has_one :is_bolsao
  has_one :shift

  accepts_nested_attributes_for :mini_exams, allow_destroy: true
  accepts_nested_attributes_for :shift, allow_destroy: true
  accepts_nested_attributes_for :is_bolsao, allow_destroy: true

  validates :name, :correct_answers, :options_per_question, presence: true
  validate :correct_answers_range, on: :create

  after_create :create_questions
  before_save :update_questions

  def number_of_questions
    exam_questions.count
  end

  def exam_subjects
    # exam_questions.map(&:question).map(&:topics).map(&:first).map(&:subject).uniq
    exam_questions.includes(:question => {:topics => :subject}).map(&:question).map(&:topics).map(&:first).map(&:subject).uniq
  end

  def exam_questions_per_subject
    exam_questions.includes(:question  => {:topics => :subject}).inject(Hash.new(0)){|h, v| h[v.topics.first.subject] += 1; h}
  end


private

  def correct_answers_range
    return if options_per_question.nil?
    # TODO: refactor
    initial_letter, final_letter = 'A', 'A'
    options_per_question.times { final_letter.next! }
    possible_letters = initial_letter..final_letter

    correct_answers.split('').each do |answer|
      unless possible_letters.include?(answer) 
        errors.add(:correct_answers, 'invalid answer: ' + answer)
      end
    end
  end

  def update_questions
    return if exam_questions.size == 0
    self.correct_answers.split('').each_with_index do |correct_letter, i|
      question_options = self.exam_questions.where(number: i+1).first.question.options
      question_options.each {|o| o.update_column(:correct, false)}
      if correct_letter == 'X'
        question_options.each{|option| option.update_column(:correct, true)}
      else
        question_options.select{|o| o.letter == correct_letter}.first.update_column(:correct, true)
      end
    end
  end

  def create_questions
    correct_answers.split('').each do |answer|
      question = Question.create!(stem: 'Stem', model_answer: 'Model Answer')

      options_per_question.times do 
        Option.create!(question_id: question.id)
      end
      question.options.where(letter: answer).first.update_attribute :correct, true

      ExamQuestion.create!(exam_id: self.id, question_id: question.id)
    end
  end

  def get_correct_answers
    exam_questions.sort{|x, y| x.number <=> y.number}.map(&:question).flatten.map{|q| q.correct_options.map(&:letter).join()}
  end 

  def correct_answers_per_subject
    all_exam_executions.group_by(&:exam_id).each do |exam_id, exam_executions|
      student_exams = StudentExam.where(exam_execution_id: exam_executions.map(&:id)).includes(:student, {:card_processing => :campus}, {:exam_answers => {:exam_question => {:question => [:options, {:topics => :subject}]}}})
      next if student_exams.size == 0

subjects = se.exam_answers.map(&:exam_question).map(&:question).map(&:topics).map(&:first).map(&:subject).uniq
subject_questions = se.exam_answers.map(&:exam_question).map{|eq| [eq.number, eq.question.topics.first.subject.name]}.inject(Hash.new(0)){|h,v| ((h[v[1]] != 0) ? h[v[1]] << v[0] : h[v[1]] = [v[0]]); h}
correct_answers = se.exam_answers.map(&:exam_question).map(&:question).map{|q| q.options.select{|o| o.correct}.map(&:letter)}
subjects.inject(Hash.new(0)){|h, v| h[v.code] = se.exam_answers.select{|exam_answer| subject_questions[v.name].include?(exam_answer.exam_question.number) && correct_answers[exam_answer.exam_question.number - 1].include?(exam_answer.answer)}.size; h}

      arr += student_exams.map do |student_exam|
        {
          'RA' => ("%07d" % student_exam.student.ra), 
          'NAME' => student_exam.student.name.split.map(&:mb_chars).map(&:capitalize).join(' '), 
          'CAMPUS' => student_exam.campus.name,
          'LINK' => view_context.link_to('Show', student_exam, target:"_blank")
        }.merge(
            subjects.inject(Hash.new(0)){|h, v| h[v.code] = se.exam_answers.select{|exam_answer| subject_questions[v.name].include?(exam_answer.exam_question.number) && correct_answers[exam_answer.exam_question.number - 1].include?(exam_answer.answer)}.size; h}
          ).merge({'GRADE' => se.exam_answers.select{|exam_answer| correct_answers[exam_answer.exam_question.number - 1].include?(exam_answer.answer)}.size})
      end
    end

    QuestionTopic.where(question_id: se.exam_answers.map(&:exam_question).map(&:question_id)).map(&:topic).map(&:subject).map(&:code).uniq

  end 
end
