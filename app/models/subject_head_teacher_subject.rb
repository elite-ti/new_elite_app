class SubjectHeadTeacherSubject < ActiveRecord::Base
  has_paper_trail

  attr_accessible :subject_head_teacher_id, :subject_id

  belongs_to :subject_head_teacher
  belongs_to :subject

  validates :subject_id, :subject_head_teacher_id, presence: true
  validates :subject_id, uniqueness: { scope: :subject_head_teacher_id }
end
