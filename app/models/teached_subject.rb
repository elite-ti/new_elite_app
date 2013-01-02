class TeachedSubject < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :subject_id, :teacher_id

  belongs_to :subject
  belongs_to :teacher

  validates :subject_id, :teacher_id, presence: true
  validates :subject_id, uniqueness: { scope: :teacher_id }
end
