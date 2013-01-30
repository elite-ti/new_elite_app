class AbsenceReason < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :name

  has_many :teacher_absences

  validates :name, presence: true, uniqueness: true
end
