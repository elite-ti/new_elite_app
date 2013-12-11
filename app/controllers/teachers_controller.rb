class TeachersController < ApplicationController
  load_and_authorize_resource

  def show
    @date = (params[:date].nil? ? Date.today : Date.new(params[:date][:product_year].to_i, params[:date][:month].to_i, params[:date][:day].to_i))
    @periods = @teacher.find_absent_periods_by_date(@date)
  end

  def update
    if @employee.teacher.update_attributes(params[:teacher])
      redirect_to @employee, notice: 'Teacher was successfully updated.'
    else
      set_employee
      render 'edit'
    end
  end
end
