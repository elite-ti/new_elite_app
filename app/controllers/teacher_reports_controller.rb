class TeacherReportsController < ApplicationController
  authorize_resource :teacher, parent: false

  def show
    @teacher = Teacher.find(params[:id])
    @date = (params[:date].nil? ? Date.today : Date.new(params[:date][:year].to_i, params[:date][:month].to_i, params[:date][:day].to_i))
    @klazz_periods = @teacher.find_monthly_klazz_periods(@date)
    @substitute_klazz_periods = @teacher.find_monthly_klazz_periods_as_substitute(@date)
  end
end
