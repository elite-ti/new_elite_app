class CampusHeadTeacherAbility < HeadTeacherAbility 
  include CanCan::Ability

  attr_reader :campus_head_teacher

  def initialize(employee)
    @campus_head_teacher = employee.campus_head_teacher
    super(employee) 
    
    can :manage, CardProcessing
  end

private
  
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