class CampusHeadTeacherProduct < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :campus_head_teacher_id, :product_id

  belongs_to :campus_head_teacher, inverse_of: :campus_head_teacher_products
  belongs_to :product

  validates :product, :campus_head_teacher, presence: true
  validates :product_id, uniqueness: { scope: :campus_head_teacher_id }
end
