class Exam < ActiveRecord::Base
  attr_accessible :date, :exam_cycle_id, :name, :subject_ids

  belongs_to :exam_cycle

  has_many :exam_subjects, dependent: :destroy
  has_many :subjects, through: :exam_subjects

  has_many :student_exams, dependent: :destroy
  has_many :students, through: :student_exams

  validates :name, :exam_cycle_id, presence: true
  validates :name, uniqueness: { scope: :exam_cycle_id }
end
