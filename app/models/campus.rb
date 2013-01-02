class Campus < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :name

  has_many :klazzes

  has_many :campus_head_teacher_campuses, dependent: :destroy
  has_many :campus_head_teachers, through: :campus_head_teacher_campuses

  has_many :picked_campuses, dependent: :destroy
  has_many :teachers, through: :picked_campuses

  has_many :campus_principals, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
