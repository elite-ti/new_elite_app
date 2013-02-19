class EmployeeAbility
  include CanCan::Ability

  def initialize(employee)
    @employee = employee

    can :destroy, :employee_session
    can :update, :role_session
    can [:read, :update], Employee, id: employee.id
  end

protected

  attr_reader :employee
end
