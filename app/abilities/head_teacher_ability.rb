class HeadTeacherAbility < EmployeeAbility
  include CanCan::Ability

  def initialize(employee)
    super(employee) 

    can :read, Employee, id: accessible_employee_ids 
    can :read, Period, teacher_id: accessible_teacher_ids

    can :read, Campus, id: accessible_campus_ids
    can :read, Klazz, id: accessible_klazz_ids
    can :read, Period, klazz_id: accessible_klazz_ids
  end

protected

  def accessible_klazz_ids
    @accessible_klazz_ids ||= accessible_klazzes.map(&:id) 
  end

  def accessible_campus_ids
    @accessible_campus_ids ||= accessible_klazzes.map(&:campus_id)
  end

  def accessible_teacher_ids
    @accessible_teacher_ids ||= accessible_teachers.map(&:id)
  end

  def accessible_employee_ids
    @accessible_employee_ids ||= accessible_teachers.map(&:employee_id)
  end
end