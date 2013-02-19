class AdminAbility < EmployeeAbility
  include CanCan::Ability

  def initialize(employee)
    can :manage, :all
  end
end

