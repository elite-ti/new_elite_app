class KlazzType < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :name

  has_many :time_tables
  has_many :teacher_absences

  validates :name, presence: true, uniqueness: true
end
