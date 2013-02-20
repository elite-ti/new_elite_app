class Student < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :email, :name, :password_digest, :ra, :gender,
    :cpf, :own_cpf, :rg, :rg_expeditor, :date_of_birth, :number_of_children, 
    :mother_name, :father_name, :telephone, :cellphone, :previous_school,
    :address_attributes, :applied_product_year_ids, :enrolled_klazz_ids

  has_many :enrollments, dependent: :destroy, inverse_of: :student
  has_many :enrolled_klazzes, through: :enrollments, source: :klazz
  has_many :enrolled_product_years, through: :enrolled_klazzes, source: :product_year
  has_many :enrolled_exam_cycles, through: :enrolled_product_years, source: :exam_cycles
  has_many :enrolled_exams, through: :enrolled_exam_cycles, source: :exams

  has_many :applicants, dependent: :destroy, inverse_of: :student
  has_many :applied_product_years, through: :applicants, source: :product_year
  has_many :applied_exam_cycles, through: :applied_product_years, source: :exam_cycles
  has_many :applied_exams, through: :applied_exam_cycles, source: :exams

  has_many :student_exams, dependent: :destroy
  has_many :exams, through: :student_exams

  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address

  validates :name, presence: true
  validates :email, :ra, uniqueness: true, allow_blank: true

  def possible_exams(is_bolsao, exam_date)
    (is_bolsao ? applied_exams : enrolled_exams).
      where(datetime: (exam_date.beginning_of_day)..(exam_date.end_of_day))
  end
end
