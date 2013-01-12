class ExamQuestion < ActiveRecord::Base
  attr_accessible :exam_id, :question_id

  belongs_to :exam
  belongs_to :question

  validates :number, :exam, :question, presence: true
  validates :question_id, uniqueness: { scope: :exam_id }

  before_validation :set_number

private

  def set_number
    self.number = ExamQuestion.where(exam_id: exam_id).count + 1
  end
end
