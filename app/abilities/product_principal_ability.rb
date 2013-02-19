class ProductPrincipalAbility < EmployeeAbility 
  include CanCan::Ability

  def initialize(employee)
    super(employee) 
  end
end