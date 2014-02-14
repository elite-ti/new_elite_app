# encoding: UTF-8
class EmployeesController < ApplicationController
  load_and_authorize_resource

  def index
    @employees = @employees.includes(:teacher).all
  end

  def show
  end

  def new
    set_employee
  end

  def edit
    set_employee
  end

  def create
    if @employee.save
      redirect_to @employee, notice: 'Funcionário criado com sucesso.'
    else
      set_employee
      render 'new'
    end
  end

  def update
    if @employee.update_attributes(params[:employee]) || @employee.teacher.update_attributes(params[:teacher])
      redirect_to @employee, notice: 'Funcionário editado com sucesso.'
    else
      set_employee
      render 'edit'
    end
  end

  def import
    ExamCsvImportWorker.perform_async(params[:file].tempfile.path, current_employee.email)
    redirect_to root_url, notice: "Usuários importados com sucesso."    
  end

private

  def set_employee
    @employee.build_roles
    @employee.build_address if @employee.address.nil?
    @employee.teacher.build_product_group_preferences
    @employee.teacher.professional_experiences.build if @employee.teacher.professional_experiences.empty?
  end
end
