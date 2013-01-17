class Applicant < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :number, :bolsao_id, :student_id, :exam_datetime, 
    :exam_campus_id, :subscription_datetime, :year_id, :intended_campus_id

  belongs_to :student

  validates :number, :bolsao_id, :student_id, presence: true
  validates :number, uniqueness: { scope: :bolsao_id }
end