class Question < ActiveRecord::Base
  attr_accessible :name

  has_many :exam_questions, dependent: :destroy
  has_many :exams, through: :exam_questions

  validates :name, presence: true, uniqueness: true
end
