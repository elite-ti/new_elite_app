class Campus < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :name, :code

  has_many :klazzes
  has_many :product_years, through: :klazzes
  has_many :products, through: :product_years

  has_many :campus_head_teacher_campuses, dependent: :destroy
  has_many :campus_head_teachers, through: :campus_head_teacher_campuses

  has_many :campus_preferences, dependent: :destroy
  has_many :teachers, through: :campus_preferences

  has_many :campus_principals, dependent: :destroy

  has_many :card_processings, dependent: :destroy

  validates :name, :code, presence: true, uniqueness: true
end
