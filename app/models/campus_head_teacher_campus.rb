class CampusHeadTeacherCampus < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :campus_head_teacher_id, :campus_id

  belongs_to :campus
  belongs_to :campus_head_teacher

  validates :campus_id, :campus_head_teacher_id, presence: true
  validates :campus_id, uniqueness: { scope: :campus_head_teacher_id }
end
