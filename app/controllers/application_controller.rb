class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

protected

  def login(user, notice = 'Logged In!')
    session[:user_id] = user.id
    redirect_to root_url, notice: 'Logged in!'
  end

  def logout(notice = 'Logged Out!')
    session[:user_id] = session[:queued_user_id].try(:pop)
    redirect_to root_url, notice: notice
  end

private

  def current_ability
    @current_ability ||= set_current_ability
  end
  helper_method :current_ability

  def set_current_ability
    return GuestAbility.new if current_role.nil?
    return "#{current_role.camelize}Ability".constantize.new(current_employee)
  end

  def current_role
    @current_role ||= set_current_role
  end
  helper_method :current_role

  def set_current_role
    return nil if current_employee.nil?

    if current_employee.roles.include? session[:role]
      return session[:role]
    else
      return current_employee.roles.first
    end
  end

  def current_employee
    @current_employee ||= set_current_employee
  end
  helper_method :current_employee

  def set_current_employee
    Employee.find(session[:user_id]) if session[:user_id]
  end
end
