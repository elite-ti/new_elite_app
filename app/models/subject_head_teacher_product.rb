class SubjectHeadTeacherProduct < ActiveRecord::Base
  has_paper_trail

  attr_accessible :product_id, :subject_head_teacher_id

  belongs_to :subject_head_teacher
  belongs_to :product

  validates :product_id, :subject_head_teacher_id, presence: true
  validates :product_id, uniqueness: { scope: :subject_head_teacher_id }
end
