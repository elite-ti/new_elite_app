class ExamQuestion < ActiveRecord::Base
  attr_accessible :exam_id, :question_id

  belongs_to :exam
  belongs_to :question

  validates :exam_id, :question_id, presence: true
  validates :question_id, uniqueness: { scope: :exam_id }
end
