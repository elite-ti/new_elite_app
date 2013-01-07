module LoginMacros
  Employee::ROLES.each do |role|
    define_method "log_#{role}_in" do
      employee = FactoryGirl.create :employee, roles: [role]
      employee.send("create_#{role}")
      
      OmniAuth.config.add_mock(:google_oauth2, {info: {email: employee.email}, uid: employee.elite_id})
      visit root_url
      click_on 'Log In'
    end
  end
end