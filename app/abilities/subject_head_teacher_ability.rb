class SubjectHeadTeacherAbility < EmployeeAbility 
  include CanCan::Ability

  def initialize(employee)
    super(employee) 
    @subject_head_teacher = employee.subject_head_teacher
  end

private
  
  attr_reader :subject_head_teacher
  delegate :products, :subjects, to: :subject_head_teacher

  def accessible_klazzes
    @accessible_klazzes ||= 
      (products.includes(:klazzes).map(&:klazzes).flatten &
      subjects.includes(:klazzes).map(&:klazzes).flatten).uniq
  end
  
  def accessible_teachers
    @accessible_teachers ||= accessible_klazzes.map(&:teachers).flatten.uniq
  end
end