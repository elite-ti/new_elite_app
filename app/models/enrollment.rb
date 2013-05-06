class Enrollment < ActiveRecord::Base
  
  attr_accessible :super_klazz_id, :student_id

  belongs_to :student, inverse_of: :enrollments
  belongs_to :super_klazz

  validates :student, :super_klazz, presence: true
  validates :student_id, uniqueness: { scope: :super_klazz_id }
end
