class Applicant < ActiveRecord::Base
  
  attr_accessible :number, :bolsao_id, :student_id, :exam_datetime, 
    :exam_campus_id, :subscription_datetime, :super_klazz_id, :student, :exam_campus, :student_attributes, :group_name

  belongs_to :student, inverse_of: :applicants
  belongs_to :super_klazz
  belongs_to :exam_campus, class_name: :Campus

  validates :student, presence: true
  delegate :email, :name, :cpf, :own_cpf, :date_of_birth, :mother_name, :father_name, :telephone, :cellphone, to: :student
  accepts_nested_attributes_for :student

  # validates :number, uniqueness: { scope: :bolsao_id }
  # validates :student_id, uniqueness: { scope: :product_year_id }

  # def campus
  #   Campus.find(exam_campus_id)
  # end

  # def campus= value
  #   exam_campus_id = value.id
  # end

  # def product_year
  #   super_klazz.try(:product_year)
  # end
end