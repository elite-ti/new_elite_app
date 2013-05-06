class AbsenceReason < ActiveRecord::Base
  
  attr_accessible :name

  has_many :teacher_absences

  validates :name, presence: true, uniqueness: true
end
