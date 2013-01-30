class ProductHeadTeacherProduct < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :product_head_teacher_id, :product_id

  belongs_to :product_head_teacher
  belongs_to :product

  validates :product_head_teacher_id, :product_id, presence: true
  validates :product_id, uniqueness: { scope: :product_head_teacher_id }
end
