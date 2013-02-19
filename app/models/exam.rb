class Exam < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :datetime, :exam_cycle_id, :name, :subject_ids,
    :correct_answers, :options_per_question

  belongs_to :exam_cycle

  has_many :exam_subjects, dependent: :destroy, inverse_of: :exam
  has_many :subjects, through: :exam_subjects

  has_many :exam_questions, dependent: :destroy, inverse_of: :exam
  has_many :questions, through: :exam_questions

  has_many :student_exams, dependent: :destroy
  has_many :students, through: :student_exams

  validates :name, :exam_cycle_id, :correct_answers, :options_per_question,
    :datetime, presence: true
  validates :name, uniqueness: { scope: :exam_cycle_id }
  validate :correct_answers_range, on: :create

  after_create :create_questions

  def number_of_questions
    exam_questions.count
  end

private

  def correct_answers_range
    return if options_per_question.nil?
    # TODO: fix implementation
    initial_letter, final_letter = 'A', 'A'
    options_per_question.times { final_letter.next! }
    possible_letters = initial_letter..final_letter

    correct_answers.split('').each do |answer|
      unless possible_letters.include?(answer) 
        errors.add(:correct_answers, 'invalid answer: ' + answer)
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
end
