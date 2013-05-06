class CampusHeadTeacher < ActiveRecord::Base
  
  attr_accessible :employee_id, :product_ids, :campus_ids

  belongs_to :employee

  has_many :campus_head_teacher_products, dependent: :destroy, inverse_of: :campus_head_teacher
  has_many :products, through: :campus_head_teacher_products

  has_many :campus_head_teacher_campuses, dependent: :destroy, inverse_of: :campus_head_teacher
  has_many :campuses, through: :campus_head_teacher_campuses

  validates :employee_id, presence: true, uniqueness: true, on: :update
end
