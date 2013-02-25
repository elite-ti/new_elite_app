class Klazz < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :super_klazz_id, :name

  belongs_to :super_klazz

  has_many :ticks, dependent: :destroy
  has_many :topics, through: :ticks

  has_many :periods, dependent: :destroy 
  has_many :teachers, through: :periods
  has_many :subjects, through: :periods

  validates :name, :super_klazz, presence: true
  validates :name, uniqueness: true

  def label_method
    name + ' - ' + campus.name
  end
end
