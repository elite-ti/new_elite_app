class EmployeesController < ApplicationController
  load_and_authorize_resource

  def index
    @employees = @employees.includes(:teacher).all
  end

  def new
    set_employee
  end

  def edit
    set_employee
  end

  def create
    if @employee.save
      redirect_to employees_url, notice: 'Employee was successfully created.'
    else
      set_employee
      render 'new'
    end
  end

  def update
    if @employee.update_attributes(params[:employee])
      redirect_to employees_url, notice: 'Employee was successfully updated.'
    else
      set_employee
      render 'edit'
    end
  end

private

  def set_employee
    @employee.build_roles
    @employee.teacher.professional_experiences.build if @employee.teacher.professional_experiences.empty?
    @employee.teacher.build_product_group_preferences
  end
end
