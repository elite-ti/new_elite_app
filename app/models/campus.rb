class Campus < ActiveRecord::Base
  
  attr_accessible :name, :code, :erp_code

  has_many :super_klazzes

  has_many :klazzes, through: :super_klazzes
  has_many :product_years, through: :super_klazzes
  has_many :products, through: :product_years

  has_many :enrollments, through: :super_klazzes
  has_many :enrolled_students, through: :enrollments, source: :student
  has_many :applicants, through: :super_klazzes
  has_many :applicant_students, through: :applicants, source: :student

  has_many :campus_head_teacher_campuses, dependent: :destroy
  has_many :campus_head_teachers, through: :campus_head_teacher_campuses

  has_many :campus_preferences, dependent: :destroy
  has_many :teachers_with_preference, through: :campus_preferences, source: :teachers

  has_many :campus_principal_campuses, dependent: :destroy
  has_many :campus_principals, through: :campus_principal_campuses 

  has_many :card_processings, dependent: :destroy

  validates :name, :code, presence: true, uniqueness: true
end
