class CampusHeadTeacherAbility < HeadTeacherAbility 
  include CanCan::Ability

  def initialize(employee)
    super(employee) 
    @campus_head_teacher = employee.campus_head_teacher
    can :manage, CardProcessing
  end

private
  
  attr_reader :campus_head_teacher
  delegate :products, :campuses, to: :campus_head_teacher

  def accessible_klazzes
    @accessible_klazzes ||= 
      (products.includes(klazzes: :teachers).map(&:klazzes).flatten &
      campuses.includes(klazzes: :teachers).map(&:klazzes).flatten).uniq
  end
  
  def accessible_teachers
    @accessible_teachers ||= accessible_klazzes.map(&:teachers).flatten.uniq
  end
end