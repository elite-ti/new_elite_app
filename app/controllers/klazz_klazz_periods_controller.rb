class KlazzTimeTablesController < ApplicationController
  authorize_resource :klazz, parent: false

  def show
    @klazz = Klazz.find(params[:id])
    @date = (params[:date] ? Date.parse(params[:date]) : Date.today).beginning_of_week
    @dates = @date..(@date+5.days)
    @times = TimeTable.time_array
  end
end
