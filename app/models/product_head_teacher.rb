class ProductHeadTeacher < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :employee_id, :product_ids

  belongs_to :employee

  has_many :product_head_teacher_products, dependent: :destroy
  has_many :products, through: :product_head_teacher_products

  validates :employee_id, presence: true, uniqueness: true, on: :update

  def accessible_klazz_ids
    products.includes(:klazzes).
      map(&:klazzes).flatten.uniq.map(&:id)
  end

  def accessible_teaching_assignment_ids
    products.includes(klazzes: :teaching_assignments).
      map(&:klazzes).flatten.uniq.map(&:teaching_assignment_ids).flatten.uniq
  end
end
