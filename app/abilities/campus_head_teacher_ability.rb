class CampusHeadTeacherAbility < EmployeeAbility 
  include CanCan::Ability

  def initialize(employee)
    super(employee)
    @campus_head_teacher = employee.campus_head_teacher

    # can :read, Employee, id: accessible_employee_ids 
    can :read, Period

    can :read, Campus, id: accessible_campus_ids
    can :read, Klazz, super_klazz: { campus_id: accessible_campus_ids }
    can :read, Teacher, id: accessible_teacher_ids
    can [:read, :update, :create], Student
    can [:read, :update, :create], Applicant, exam_campus_id: accessible_campus_ids

    can :read, ExamExecution, campus_id: accessible_campus_ids
    can :read, :update, :create, StudentExam
    
    can :create, CardProcessing 
    can :read, CardProcessing, campus_id: accessible_campus_ids

    can [:read], StudentExam, 
      card_processing: { campus_id: accessible_campus_ids }

    can [:update, :error, :new], StudentExam

    # TODO: 
    # can add teacher absence
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

  def accessible_teachers
    @accessible_teachers ||= Teacher.all
  end

  def accessible_campus_ids
    @accessible_campus_ids ||= campuses.map(&:id)
  end 
end