class AnswerCardType < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :card, :name, :parameters

  has_many :student_exams

  validates :card, :name, :parameters, presence: true
  validates :name, uniqueness: true

  mount_uploader :card, AnswerCardTypeUploader
end
