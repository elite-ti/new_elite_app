class ApplicationController < ActionController::Base
  protect_from_forgery

  # http_basic_authenticate_with :name => "elite", :password => "elite123"

  rescue_from CanCan::AccessDenied do |exception|
    if current_employee.present?
      logger.warn '!!AccessDenied!!'
      logger.warn 'Employee email: ' + current_employee.email
      logger.warn 'Current role: ' + current_role
    else
      logger.warn '!!AccessDenied!!'
      logger.warn 'Guest user.'
    end
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

  def user_for_paper_trail
    current_employee && current_employee.id
  end

  def current_ability
    @current_ability ||= set_current_ability
  end
  helper_method :current_ability

  def set_current_ability
    return GuestAbility.new if current_role.nil?
    return "#{current_role.camelize}Ability".constantize.new(current_employee)
  end

  def current_role
    return nil if current_employee.nil?

    if current_employee.roles.include? session[:role]
      return session[:role]
    else
      return current_employee.roles.last
    end
  end
  helper_method :current_role

  def current_employee
    @current_employee ||= set_current_employee
  end
  helper_method :current_employee

  def set_current_employee
    Employee.find(session[:user_id]) if session[:user_id]
  end
end
