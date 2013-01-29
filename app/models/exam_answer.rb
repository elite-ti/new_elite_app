class ExamAnswer < ActiveRecord::Base
  has_paper_trail

  VALID_STATUS = 'Valid'
  CHECKED_STATUS = 'Checked'
  INVALID_STATUS = 'Invalid'

  VALID_ANSWERS = %w[A B C D E]
  INVALID_ANSWERS = %w[Z W]
  ANSWERS = VALID_ANSWERS + INVALID_ANSWERS
  
  attr_accessible :answer, :exam_question_id, :student_exam_id, :status
  belongs_to :exam_question
  belongs_to :student_exam

  validates :answer, :exam_question_id, :student_exam_id, :status, presence: true
  validates :exam_question_id, uniqueness: { scope: :student_exam_id }

  before_validation :set_status, on: :create

  def invalid?
    status == INVALID_STATUS
  end

  def image_url
    student_exam.card.question_url(exam_question.number)
  end

private

  # status: 'Valid', 'Invalid', 'Checked'
  def set_status
    if valid_answer?
      self.status = VALID_STATUS
    else
      self.status = INVALID_STATUS
    end
  end

  def valid_answer?
    VALID_ANSWERS.include?(answer) and not INVALID_ANSWERS.include?(answer)
  end
end
