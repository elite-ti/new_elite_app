class Student < ActiveRecord::Base
  attr_accessible :email, :name, :password_digest, :ra

  has_many :enrollments, dependent: :destroy
  has_many :klazz, through: :enrollments

  has_many :student_exams, dependent: :destroy
  has_many :exams, through: :student_exams

  validates :name, :ra, presence: true
  validates :email, :ra, uniqueness: true
end
