class CampusHeadTeacherAbility < EmployeeAbility 
  include CanCan::Ability

  def initialize(employee)
    super(employee)
    @campus_head_teacher = employee.campus_head_teacher

    can :read, Employee, id: accessible_employee_ids 
    can :read, Period

    can :read, Campus, id: accessible_campus_ids
    can :read, Klazz, campus_id: accessible_campus_ids
    
    can :create, CardProcessing 
    can [:read, :update], CardProcessing, campus_id: accessible_campus_ids
    can :update, StudentExam, card_processing: { campus_id: accessible_campus_ids }

    # TODO: maybe
    # can add teacher absence
    # can manage exams
  end

private
  
  attr_reader :campus_head_teacher
  delegate :campuses, to: :campus_head_teacher

  def accessible_employee_ids
    @accessible_employee_ids ||= Teacher.all.map(&:employee_id)
  end

  def accessible_campus_ids
    @accessible_campus_ids ||= campuses.map(&:id)
  end 
end