class ExamComponent < ActiveRecord::Base
	has_paper_trail

  attr_accessible :exam_id, :super_exam_id

  belongs_to :exam
  belongs_to :super_exam

  validates :exam, :super_exam, presence: true
  validates :exam_id, uniqueness: { scope: :super_exam_id }
end
