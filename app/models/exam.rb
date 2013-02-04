class Exam < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :datetime, :exam_cycle_id, :name, :subject_ids, :question_ids

  belongs_to :exam_cycle

  has_many :exam_subjects, dependent: :destroy, inverse_of: :exam
  has_many :subjects, through: :exam_subjects

  has_many :exam_questions, dependent: :destroy, inverse_of: :exam
  has_many :questions, through: :exam_questions

  has_many :student_exams, dependent: :destroy
  has_many :students, through: :student_exams

  validates :name, :exam_cycle_id, presence: true
  validates :name, uniqueness: { scope: :exam_cycle_id }
  validate :question_belongs_to_subjects

  def number_of_questions
    exam_questions.count
  end

private

  def questions_belong_to_subjects
    unless (questions.map(&:subjects).uniq - subjects).empty?
      errors.add(:question_ids, 'questions must belong to subjects')
    end
  end
end
