class Exam < ActiveRecord::Base  
  attr_accessible :name, :options_per_question, :correct_answers

  has_many :exam_questions, dependent: :destroy, inverse_of: :exam
  has_many :questions, through: :exam_questions

  has_many :exam_executions, dependent: :destroy

  validates :name, :correct_answers, :options_per_question, presence: true
  validate :correct_answers_range, on: :create

  after_create :create_questions
  before_save :update_questions

  def number_of_questions
    exam_questions.count
  end

  def exam_subjects
    exam_questions.map(&:question).map(&:topics).map(&:first).map(&:subject).uniq
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
    self.correct_answers.split('').each_with_index do |correct_letter, i|
      question_options = self.exam_questions.where(number: i+1).first.question.options
      question_options.each {|o| o.update_column(:correct, false)}
      question_options.select{|o| o.letter == correct_letter}.first.update_column(:correct, true)
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
end
