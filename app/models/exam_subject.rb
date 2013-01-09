class ExamSubject < ActiveRecord::Base
  attr_accessible :exam_id, :subject_id

  belongs_to :exam
  belongs_to :subject

  validates :exam_id, :subject_id, presence: true
  validates :subject_id, uniqueness: { scope: :exam_id }
end
