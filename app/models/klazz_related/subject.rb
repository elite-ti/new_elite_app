class Subject < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :name, :short_name, :code

  default_scope order('name')

  has_many :subject_head_teacher_subjects, dependent: :destroy
  has_many :subject_head_teachers, through: :subject_head_teacher_subjects

  has_many :teached_subjects, dependent: :destroy
  has_many :teachers, through: :teached_subjects

  has_many :year_subjects, dependent: :destroy
  has_many :years, through: :year_subjects

  has_many :teaching_assignments
  has_many :klazzes, through: :teaching_assignments

  has_many :teacher_absences

  validates :name, :short_name, :code, presence: true, uniqueness: true
end
