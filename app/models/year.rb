class Year < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :name, :product_id, :year_number

  belongs_to :product

  has_many :exam_cycles, dependent: :destroy
  has_many :subject_threads, dependent: :destroy

  has_many :klazzes, dependent: :destroy
  has_many :enrollments, through: :klazzes
  has_many :enrolled_students, through: :enrollments, source: :student

  has_many :applicants
  has_many :applicant_students, through: :applicants, source: :student
  
  validates :product_id, :name, :year_number, presence: true
  validates :name, uniqueness: { scope: :product_id }
end
