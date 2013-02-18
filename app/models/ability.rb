class Ability
  include CanCan::Ability

  def initialize(employee, role)
    @employee = employee

    can :update, :role_session if employee
    send(role + '_ability') if employee && role
  end

  def employee
    @employee
  end

  def admin_ability
    can :manage, :all
  end

  def hr_ability
  end

  def teacher_ability
    can [:read, :update], Employee, id: employee.id
    can :read, Klazz, id: employee.teacher.klazz_ids
  end

  def product_head_teacher_ability
    klazz_ids = employee.product_head_teacher.accessible_klazz_ids
    can :read, Klazz, id: klazz_ids 
    can :read, Period, klazz_id: klazz_ids
  end

  def campus_head_teacher_ability
    klazz_ids = employee.campus_head_teacher.accessible_klazz_ids
    can :read, Klazz, id: klazz_ids
    can :read, Period, klazz_id: klazz_ids
  end

  def subject_head_teacher_ability
    klazz_ids = employee.subject_head_teacher.accessible_klazz_ids
    can :read, Klazz, id: klazz_ids
    can :read, Period, klazz_id: klazz_ids
  end

  def product_principal_ability
    klazz_ids = employee.campus_principal.accessible_klazz_ids
    can :read, Klazz, id: klazz_ids
    can :read, Period, klazz_id: klazz_ids
  end

  def campus_principal_ability
    klazz_ids = employee.campus_principal.accessible_klazz_ids
    can :read, Klazz, id: klazz_ids
    can :read, Period, klazz_id: klazz_ids
  end
end
