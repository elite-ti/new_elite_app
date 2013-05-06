class Klazz < ActiveRecord::Base
  
  attr_accessible :super_klazz_id, :name

  belongs_to :super_klazz
  has_many :periods, dependent: :destroy 
  has_many :teachers, through: :periods
  has_many :subjects, through: :periods

  validates :name, :super_klazz, presence: true
  validates :name, uniqueness: true
end
