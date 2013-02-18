class SubjectHeadTeacherProduct < ActiveRecord::Base
  has_paper_trail

  attr_accessible :product_id, :subject_head_teacher_id

  belongs_to :subject_head_teacher, inverse_of: :subject_head_teacher_products
  belongs_to :product

  validates :product, :subject_head_teacher, presence: true
  validates :product_id, uniqueness: { scope: :subject_head_teacher_id }
end
