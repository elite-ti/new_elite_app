class ExamAnswer < ActiveRecord::Base
  has_paper_trail

  VALID_ANSWERS = %w[A B C D E]
  INVALID_ANSWERS = %w[Z W]
  
  attr_accessible :answer, :exam_question_id, :student_exam_id

  belongs_to :exam_question
  belongs_to :student_exam

  validates :answer, :exam_question_id, :student_exam_id, presence: true
  validates :exam_question_id, uniqueness: { scope: :student_exam_id }

  before_create :set_needs_check

private

  def set_needs_check
    self.needs_check = !valid_answer?
    true
  end

  def valid_answer?
    VALID_ANSWERS.include?(answer) and not INVALID_ANSWERS.include?(answer)
  end
end
