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
    can [:show, :update], Employee, id: employee.id
    can [:show, :update], Teacher, id: employee.teacher.id
    can :read, Klazz, id: employee.teacher.klazz_ids
  end

  def product_head_teacher_ability
    can :manage, Klazz, id: employee.product_head_teacher.accessible_klazz_ids
    can :create, KlazzPeriod
    can :update, KlazzPeriod, teaching_assignment_id: employee.product_head_teacher.accessible_teaching_assignment_ids
  end

  def campus_head_teacher_ability
    can :manage, Klazz, id: employee.campus_head_teacher.accessible_klazz_ids
    can :create, KlazzPeriod
    can :update, KlazzPeriod, teaching_assignment_id: employee.campus_head_teacher.accessible_teaching_assignment_ids
  end

  def subject_head_teacher_ability
    can :manage, Klazz, id: employee.subject_head_teacher.accessible_klazz_ids
    can :create, KlazzPeriod
    can :update, KlazzPeriod, teaching_assignment_id: employee.subject_head_teacher.accessible_teaching_assignment_ids
  end

  def campus_principal_ability
    can :manage, Klazz, id: employee.campus_principal.accessible_klazz_ids
    can :create, KlazzPeriod
    can :update, KlazzPeriod, teaching_assignment_id: employee.campus_principal.accessible_teaching_assignment_ids
    can :manage, TeacherAbsence, id: employee.campus_principal.accessible_teacher_absence_ids
  end
end
