class SchoolRole < ActiveRecord::Base

  has_many :professional_experiences

  attr_accessible :name

  validates :name, presence: true, uniqueness: true
end
