class TeacherReportsController < ApplicationController
  authorize_resource :teacher, parent: false

  def show
    @teacher = Teacher.find(params[:id])
    @date = (params[:date].nil? ? Date.today : Date.new(params[:date][:year].to_i, params[:date][:month].to_i, params[:date][:day].to_i))
    @time_tables = @teacher.find_monthly_time_tables(@date)
    @substitute_time_tables = @teacher.find_monthly_time_tables_as_substitute(@date)
  end
end
