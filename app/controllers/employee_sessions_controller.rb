class EmployeeSessionsController < ApplicationController
  authorize_resource class: false, only: :update

  def create
    employee = Employee.find_by_email(env['omniauth.auth']['info']['email'])
    if employee
      employee.check_uid(env['omniauth.auth']['uid'])
      login employee
    else
      redirect_to root_url, notice: 'Email address not found.'
    end
  end

  def update
    session[:queued_user_id] ||= []
    session[:queued_user_id].push session[:user_id]
    login Employee.find(params[:id])
  end

  def destroy
    logout
  end
end
