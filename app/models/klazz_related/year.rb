class Year < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :name, :product_id

  belongs_to :product
  has_many :klazzes
  
  has_many :year_subjects, dependent: :destroy
  has_many :subjects, through: :year_subjects
  has_many :schedules, through: :year_subjects

  validates :product_id, :name, presence: true
  validates :name, uniqueness: { scope: :product_id }
end
