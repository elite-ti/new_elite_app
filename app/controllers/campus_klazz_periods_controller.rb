class CampusTimeTablesController < ApplicationController
  authorize_resource class: false

  def show
    @campus = Campus.find(params[:id])
    @klazzes = @campus.klazzes.order('name asc')
    @date = (params[:date] ? Date.parse(params[:date]) : Date.today).beginning_of_week
    @dates = @date..(@date+5.days)
    @times = TimeTable.time_array
  end
end
