class Enrollment < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :klazz_id, :student_id

  belongs_to :student, inverse_of: :enrollments
  belongs_to :klazz

  validates :student, :klazz, presence: true
  validates :student_id, uniqueness: { scope: :klazz_id }
end
