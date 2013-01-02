class Major < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :name

  has_many :teachers

  validates :name, presence: true, uniqueness: true
end
