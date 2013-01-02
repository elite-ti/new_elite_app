class Schedule < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :year_subject_id, :name

  belongs_to :year_subject
  has_many :topics, dependent: :destroy
  # has_many :teaching_assignments, dependent: :destroy
  # has_many :teacher_absences

  validates :year_subject_id, :name, presence: true
  validates :name, uniqueness: { scope: :year_subject_id }
end
