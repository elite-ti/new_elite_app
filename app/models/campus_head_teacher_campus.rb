class CampusHeadTeacherCampus < ActiveRecord::Base
  
  attr_accessible :campus_head_teacher_id, :campus_id

  belongs_to :campus_head_teacher, inverse_of: :campus_head_teacher_campuses
  belongs_to :campus

  validates :campus, :campus_head_teacher, presence: true
  validates :campus_id, uniqueness: { scope: :campus_head_teacher_id }
end
