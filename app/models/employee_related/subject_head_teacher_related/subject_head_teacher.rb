class SubjectHeadTeacher < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :employee_id, :subject_ids, :product_ids

  belongs_to :employee

  has_many :subject_head_teacher_subjects, dependent: :destroy
  has_many :subjects, through: :subject_head_teacher_subjects

  has_many :subject_head_teacher_products, dependent: :destroy
  has_many :products, through: :subject_head_teacher_products

  validates :employee_id, presence: true, uniqueness: true, on: :update

  def accessible_klazz_ids
    products.includes(:klazzes).map(&:klazzes).flatten.uniq.map(&:id) &
      subjects.includes(:klazzes).map(&:klazzes).flatten.uniq.map(&:id)
  end

  def accessible_teaching_assignment_ids
    products.includes(klazzes: :teaching_assignments).map(&:klazzes).flatten.uniq.map(&:teaching_assignment_ids).flatten.uniq &
      subjects.includes(:teaching_assignments).map(&:teaching_assignment_ids).flatten.uniq
  end
end
