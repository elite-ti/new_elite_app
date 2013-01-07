class Student < ActiveRecord::Base
  attr_accessible :email, :name, :password_digest, :ra

  has_many :enrollments, dependent: :destroy
  has_many :klazz, through: :enrollments

  validates :email, :name, :ra, presence: true
  validates :email, :ra, uniqueness: true
end
