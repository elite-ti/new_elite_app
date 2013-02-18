class Subject < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :name, :short_name, :code

  has_many :topics, dependent: :destroy
  has_many :question_topics, through: :topics
  has_many :questions, through: :question_topics

  has_many :subject_threads, dependent: :destroy
  has_many :years, through: :subject_threads
  has_many :teaching_assignments, through: :subject_threads

  has_many :exam_subjects, dependent: :destroy
  has_many :exams, through: :exam_subjects

  has_many :periods, dependent: :destroy
  has_many :klazzes, through: :teaching_assignments
  has_many :teachers, through: :teaching_assignments

  validates :name, :short_name, :code, presence: true, uniqueness: true
end
