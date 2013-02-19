class ProductHeadTeacherAbility < HeadTeacherAbility 
  include CanCan::Ability

  def initialize(employee)
    super(employee) 
    @product_head_teacher = employee.product_head_teacher
  end

private
  
  attr_reader :product_head_teacher
  delegate :products, to: :product_head_teacher

  def accessible_klazzes
    @accessible_klazzes ||= products.includes(:klazzes).map(&:klazzes).flatten
  end
  
  def accessible_teachers
    @accessible_teachers ||= accessible_klazzes.map(&:teachers).flatten.uniq
  end
end