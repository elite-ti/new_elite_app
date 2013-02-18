class Applicant < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :number, :bolsao_id, :student_id, :exam_datetime, 
    :exam_campus_id, :subscription_datetime, :product_year_id, :intended_campus_id

  belongs_to :student
  belongs_to :product_year

  validates :number, :bolsao_id, :student_id, :product_year_id, presence: true
  validates :number, uniqueness: { scope: :bolsao_id }
  validates :student_id, uniqueness: { scope: :product_year_id }
end