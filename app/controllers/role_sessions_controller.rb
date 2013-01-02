class RoleSessionsController < ApplicationController
  authorize_resource class: false

  def update
    if current_employee.roles.include? params[:role]
      session[:role] = params[:role]
    else
      session[:role] = current_employee.roles.first
    end
    redirect_to :back
  end
end