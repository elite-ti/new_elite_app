class ExamAnswer < ActiveRecord::Base
  has_paper_trail

  ANSWERS_TO_BE_CHECKED = %w[W Z]

  attr_accessible :answer, :student_exam_id
  belongs_to :student_exam

  validates :answer, :student_exam_id, presence: true

  after_save :set_number
  after_destroy :set_number

  def need_to_be_checked?
    ANSWERS_TO_BE_CHECKED.include?(answer)
  end

  def image_url
    student_exam.card.question_url(number)
  end

  def options
    student_exam.card_type.question_alternatives + ANSWERS_TO_BE_CHECKED
  end

private

  def set_number
    student_exam.exam_answers.order('number').each_with_index do |exam_question, i|
      exam_question.update_column :number, i+1
    end
    true
  end
end
