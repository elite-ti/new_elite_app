class Enrollment < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :klazz_id, :student_id

  belongs_to :student
  belongs_to :klazz

  validates :student_id, :klazz_id, presence: true
  validates :student_id, uniqueness: { scope: :klazz_id }
end
