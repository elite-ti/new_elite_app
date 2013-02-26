module LoginMacros
  def log_admin_in
    employee = FactoryGirl.create :employee, roles: ['admin']
    employee.create_admin!
    
    OmniAuth.config.add_mock(:google_oauth2, {info: {email: employee.email}, uid: employee.elite_id})
    visit root_url
    click_on 'Log In'
  end

  def log_campus_head_teacher_in
    employee = FactoryGirl.create :employee, roles: ['campus_head_teacher']
    employee.create_campus_head_teacher!(
      campus_ids: [create(:campus, name: 'AccessibleCampus').id], 
      product_ids: Product.all.map(&:id))
    
    OmniAuth.config.add_mock(:google_oauth2, {info: {email: employee.email}, uid: employee.elite_id})
    visit root_url
    click_on 'Log In'
  end
end