class SuperKlazz < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :campus_id, :product_year_id

  belongs_to :campus
  belongs_to :product_year
  has_many :klazzes, dependent: :destroy

  has_many :enrollments, dependent: :destroy
  has_many :enrolled_students, through: :enrollments, source: :student

  has_many :applicants, dependent: :destroy
  has_many :applicant_students, through: :applicants, source: :student

  validates :campus, :product_year, presence: true
  validates :product_year_id, uniqueness: { scope: :campus_id }
end
