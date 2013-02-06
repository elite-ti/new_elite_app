class TeacherAbsence < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :absence_reason_id, :delay, :delay_in_minutes, :excused, :subject_id, :teacher_id, 
    :klazz_period_id, :klazz_type_id, :justification

  belongs_to :klazz_period
  belongs_to :subject
  belongs_to :teacher
  belongs_to :absence_reason
  belongs_to :klazz_type

  validates :subject_id, :teacher_id, :absence_reason_id, :klazz_type_id, presence: true

  # scope :excused, where(excused: true)
  # scope :not_excused, where(excused: false)
end
