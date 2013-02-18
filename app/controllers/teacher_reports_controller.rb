class TeacherReportsController < ApplicationController
  authorize_resource :teacher, parent: false

  def show
    @teacher = Teacher.find(params[:id])
    @date = (params[:date].nil? ? Date.today : Date.new(params[:date][:product_year].to_i, params[:date][:month].to_i, params[:date][:day].to_i))
    @periods = @teacher.find_monthly_periods(@date)
    @substitute_periods = @teacher.find_monthly_periods_as_substitute(@date)
  end
end
