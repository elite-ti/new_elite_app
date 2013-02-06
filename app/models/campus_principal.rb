class CampusPrincipal < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :campus_id, :employee_id

  belongs_to :employee
  belongs_to :campus

  validates :campus, presence: true
  validates :employee_id, presence: true, uniqueness: true, on: :update

  def accessible_klazz_ids
    campus.klazzes.map(&:id)
  end

  def accessible_teaching_assignment_ids
    campus.klazzes.includes(:teaching_assignments).map(&:teaching_assignment_ids).flatten
  end

  def accessible_teacher_absence_ids
    TeacherAbsence.joins(klazz_period: :teaching_assignment).
      where(teaching_assignments: {klazz_id:  accessible_klazz_ids}).map(&:id)
  end
end
