class CampusHeadTeacherAbility < EmployeeAbility 
  include CanCan::Ability

  def initialize(employee)
    @campus_head_teacher = employee.campus_head_teacher
    super(employee)

    can :read, Employee, id: accessible_employee_ids 
    can :read, Period, teacher_id: accessible_teacher_ids

    can :read, Campus, id: accessible_campus_ids
    can :read, Klazz, id: accessible_klazz_ids
    can :read, Period, klazz_id: accessible_klazz_ids 
    
    can :manage, CardProcessing, campus_id: accessible_campus_ids
    # TODO:
    # can add teacher absence
    # can manage exams
  end

private
  
  attr_reader :campus_head_teacher
  delegate :campuses, to: :campus_head_teacher

  def accessible_employee_ids
    @accessible_employee_ids ||= accessible_teachers.map(&:employee_id)
  end

  def accessible_teacher_ids
    @accessible_teacher_ids ||= accessible_teachers.map(&:id)
  end

  def accessible_campus_ids
    @accessible_campus_ids ||= campuses.map(&:id)
  end 

  def accessible_klazz_ids
    @accessible_klazz_ids ||= Klazz.where(campus_id: accessible_campus_ids).map(&:id)
  end

  def accessible_teachers
    @accessible_teachers ||= Teacher.all
  end

  def accessible_campuses
    @accessible_campuses ||= campuses.includes(:klazzes)
  end
end