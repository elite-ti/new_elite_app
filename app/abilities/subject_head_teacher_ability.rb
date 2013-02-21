class SubjectHeadTeacherAbility < EmployeeAbility 
  include CanCan::Ability

  def initialize(employee)
    super(employee)
    @subject_head_teacher = employee.subject_head_teacher

    can :read, Employee, id: accessible_employee_ids 

    can :read, Campus
    can :read, Klazz
    can :read, Period 
  end

private
  
  def accessible_employee_ids
    @accessible_employee_ids ||= Teacher.all.map(&:employee_id)
  end
end