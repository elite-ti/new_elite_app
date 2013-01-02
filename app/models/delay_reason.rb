class DelayReason < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :name

  has_many :ticks

  validates :name, presence: true, uniqueness: true
end
