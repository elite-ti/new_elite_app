class ProductHeadTeacherAbility < EmployeeAbility 
  include CanCan::Ability

  def initialize(employee)
    @product_head_teacher = employee.product_head_teacher
    super(employee)

    can :read, Employee, id: accessible_employee_ids 
    can :read, Period, teacher_id: accessible_teacher_ids

    can :read, Campus
    can :read, Klazz
    can :read, Period
  end

private
  
  attr_reader :product_head_teacher

  def accessible_employee_ids
    @accessible_employee_ids ||= accessible_teachers.map(&:employee_id)
  end

  def accessible_teacher_ids
    @accessible_teacher_ids ||= accessible_teachers.map(&:id)
  end

  def accessible_teachers
    @accessible_teachers ||= Teacher.all
  end
end