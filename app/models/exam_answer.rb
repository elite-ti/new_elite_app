class ExamAnswer < ActiveRecord::Base
  has_paper_trail

  VALID_STATUS = 'Valid'
  CHECKED_STATUS = 'Checked'
  INVALID_STATUS = 'Invalid'

  ANSWERS_TO_BE_CHECKED = %w[W Z]

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

  def options
    student_exam.card_type.question_alternatives + ANSWERS_TO_BE_CHECKED
  end

private

  def set_status
    if needs_to_be_checked?
      self.status = INVALID_STATUS
    else
      self.status = VALID_STATUS
    end
  end

  def needs_to_be_checked?
    ANSWERS_TO_BE_CHECKED.include?(answer)
  end
end
