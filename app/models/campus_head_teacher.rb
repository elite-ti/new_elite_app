class CampusHeadTeacher < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :employee_id, :product_ids, :campus_ids

  belongs_to :employee

  has_many :campus_head_teacher_products, dependent: :destroy
  has_many :products, through: :campus_head_teacher_products

  has_many :campus_head_teacher_campuses, dependent: :destroy
  has_many :campuses, through: :campus_head_teacher_campuses

  validates :employee_id, presence: true, uniqueness: true, on: :update

  def accessible_klazz_ids
    products.includes(:klazzes).map(&:klazzes).flatten.uniq.map(&:id) &
      campuses.includes(:klazzes).map(&:klazzes).flatten.uniq.map(&:id)
  end

  def accessible_teaching_assignment_ids
    products.includes(klazzes: :teaching_assignments).map(&:klazzes).flatten.uniq.map(&:teaching_assignment_ids).flatten.uniq &
      campuses.includes(klazzes: :teaching_assignments).map(&:klazzes).flatten.uniq.map(&:teaching_assignment_ids).flatten.uniq
  end
end
