class Enrollment < ActiveRecord::Base
  
  attr_accessible :super_klazz_id, :student_id, :klazz_id

  belongs_to :student, inverse_of: :enrollments
  belongs_to :super_klazz
  belongs_to :klazz

  validates :student, :super_klazz, presence: true
  validates :student_id, uniqueness: { scope: :super_klazz_id }
  before_validation :set_super_klazz_id

  def set_super_klazz_id
    self.super_klazz_id = Klazz.find(klazz_id).super_klazz_id
  end
end
