class TeacherAbility < EmployeeAbility
  include CanCan::Ability

  def initialize(employee)
    super(employee)
    @teacher = employee.teacher

    can :read, Klazz, id: accessible_klazz_ids
  end

private
  
  attr_reader :teacher
  delegate :klazzes, to: :teacher

  def accessible_klazz_ids
    klazzes.map(&:id)
  end
end