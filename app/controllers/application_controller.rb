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
    @current_ability ||= Ability.new(current_employee, current_role)
  end
  helper_method :current_ability

  def current_employee
    @current_employee ||= Employee.find(session[:user_id]) if session[:user_id]
    # To skip google authentication just set your email
    @current_employee ||= Employee.find_by_email!('gustavo.schmidt@sistemaeliterio.com.br') if Rails.env == 'development'
    @current_employee
  end
  helper_method :current_employee

  def current_role
    return nil if current_employee.nil?
    if current_employee.roles.include? session[:role]
      @current_role ||= session[:role]
    else
      @current_role ||= current_employee.roles.first
    end
  end
  helper_method :current_role

  def admin?
    current_employee.admin?
  end
  helper_method :admin?
end
