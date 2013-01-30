class CampusHeadTeacherProduct < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :campus_head_teacher_id, :product_id

  belongs_to :product
  belongs_to :campus_head_teacher

  validates :product_id, :campus_head_teacher_id, presence: true
  validates :product_id, uniqueness: { scope: :campus_head_teacher_id }
end
