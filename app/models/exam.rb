class Exam < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :name, :options_per_question, :correct_answers,
    :subject_id

  belongs_to :subject
  has_many :exam_days, dependent: :destroy

  has_many :exam_questions, dependent: :destroy, inverse_of: :exam
  has_many :questions, through: :exam_questions

  has_many :exam_days, dependent: :destroy

  validates :correct_answers, :options_per_question, 
    :subject_id, presence: true
  validate :correct_answers_range, on: :create

  after_create :create_questions

  def number_of_questions
    exam_questions.count
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
    true
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
    true
  end
end
