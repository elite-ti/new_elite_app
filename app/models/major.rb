class Major < ActiveRecord::Base
  
  attr_accessible :name

  has_many :teachers

  validates :name, presence: true, uniqueness: true
end
