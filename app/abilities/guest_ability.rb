class GuestAbility
  include CanCan::Ability

  def initialize
    can :create, :employee_session
  end
end