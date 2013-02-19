class CampusPeriodsController < ApplicationController
  load_and_authorize_resource :campus
  load_and_authorize_resource :period, through: :campus
  
  layout false

  def index
    set_week
  end

private

  def set_week
    monday = (params[:date] ? Date.parse(params[:date]) : Date.current).beginning_of_week
    @week = monday..(monday + 5.days)
  end
end