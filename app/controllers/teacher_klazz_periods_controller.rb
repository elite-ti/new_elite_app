class TeacherTimeTablesController < ApplicationController
  authorize_resource :teacher, parent: false

  def show
    @teacher = Teacher.find(params[:id])
    @date = (params[:date] ? Date.parse(params[:date]) : Date.today).beginning_of_week
    @dates = @date..(@date+5.days)
    @times = TimeTable.time_array
  end
end