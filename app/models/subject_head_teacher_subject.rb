class SubjectHeadTeacherSubject < ActiveRecord::Base
  has_paper_trail

  attr_accessible :subject_head_teacher_id, :subject_id

  belongs_to :subject_head_teacher, inverse_of: :subject_head_teacher_subjects
  belongs_to :subject

  validates :subject, :subject_head_teacher, presence: true
  validates :subject_id, uniqueness: { scope: :subject_head_teacher_id }
end
