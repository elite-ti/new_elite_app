class SubjectHeadTeacher < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :employee_id, :subject_ids, :product_ids

  belongs_to :employee

  has_many :subject_head_teacher_subjects, dependent: :destroy, inverse_of: :subject_head_teacher
  has_many :subjects, through: :subject_head_teacher_subjects

  has_many :subject_head_teacher_products, dependent: :destroy, inverse_of: :subject_head_teacher
  has_many :products, through: :subject_head_teacher_products

  validates :employee_id, presence: true, uniqueness: true, on: :update
end
