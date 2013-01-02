class YearSubject < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :subject_id, :year_id, :subject_head_teacher_id

  belongs_to :subject
  belongs_to :year
  belongs_to :subject_head_teacher
  has_many :schedules, dependent: :destroy

  validates :subject_id, :year_id, presence: true
  validates :subject_id, uniqueness: { scope: :year_id }
end
