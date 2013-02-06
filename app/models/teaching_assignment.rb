class TeachingAssignment < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :klazz_id, :time, :subject_id, :teacher_id

  belongs_to :klazz
  belongs_to :subject
  belongs_to :teacher
  has_many :klazz_periods, dependent: :destroy

  validates :klazz_id, :subject_id, :teacher_id, presence: true
end
