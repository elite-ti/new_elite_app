class Student < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :email, :name, :password_digest, :ra, :gender,
    :cpf, :own_cpf, :rg, :rg_expeditor, :date_of_birth, :number_of_children, 
    :mother_name, :father_name, :address_id, :telephone, :cellphone, :previous_school
  attr_accessor :previous_school

  has_many :enrollments, dependent: :destroy
  has_many :klazzes, through: :enrollments
  has_many :enrolled_years, through: :klazzes, source: :year
  has_many :enrolled_exam_cycles, through: :enrolled_years, source: :exam_cycle
  has_many :enrolled_exams, through: :enrolled_exam_cycles, source: :exam

  has_many :applicants, dependent: :destroy
  has_many :applied_years, through: :applicants, source: :year
  has_many :applied_exam_cycles, through: :applied_years, source: :exam_cycle
  has_many :applied_exams, through: :applied_exam_cycles, source: :exam

  has_many :student_exams, dependent: :destroy
  has_many :exams, through: :student_exams

  belongs_to :address

  validates :name, presence: true
  validates :email, :ra, uniqueness: true, allow_blank: true
end
