class ProductHeadTeacherProduct < ActiveRecord::Base
  
  attr_accessible :product_head_teacher_id, :product_id

  belongs_to :product_head_teacher, inverse_of: :product_head_teacher_products
  belongs_to :product

  validates :product_head_teacher, :product, presence: true
  validates :product_id, uniqueness: { scope: :product_head_teacher_id }
end
