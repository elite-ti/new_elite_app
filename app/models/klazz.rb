class Klazz < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :campus_id, :year_id, :name

  belongs_to :campus
  belongs_to :year

  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments

  has_many :ticks, dependent: :destroy
  has_many :topics, through: :ticks

  has_many :periods, dependent: :destroy 
  has_many :teachers, through: :periods
  has_many :subjects, through: :periods

  validates :name, :campus_id, :year_id, presence: true
  validates :name, uniqueness: true

  default_scope order('name')
end
