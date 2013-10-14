class ExamAnswer < ActiveRecord::Base

  ANSWERS_TO_BE_CHECKED = %w[W Z]

  attr_accessible :answer, :exam_question_id, :student_exam_id
  delegate :number, to: :exam_question

  belongs_to :exam_question
  belongs_to :student_exam

  validates :answer, :exam_question_id, :student_exam_id, presence: true
  # validates :exam_question_id, uniqueness: { scope: :student_exam_id }

  def need_to_be_checked?
    ANSWERS_TO_BE_CHECKED.include?(answer)
  end

  def image_url
    student_exam.card.question_url(exam_question.number)
  end

  def options
    student_exam.card_type.question_alternatives + ANSWERS_TO_BE_CHECKED
  end
end
