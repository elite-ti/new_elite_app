class ExamSubject < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :exam_id, :subject_id

  belongs_to :exam
  belongs_to :subject

  validates :exam, :subject, presence: true
  validates :subject_id, uniqueness: { scope: :exam_id }
end
