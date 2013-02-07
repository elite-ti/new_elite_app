class KlazzCalendarsController < ApplicationController
  authorize_resource class: false

  def show
    @klazz_calendar = KlazzCalendar.new(params[:id], params[:date])
    render :show, layout: false
  end

  def new
    @klazz_period = KlazzPeriod.new_from_klazz(params[:klazz_id], params[:date], params[:position])
    render :new, layout: false
  end

  def create
  end

  def edit
    @klazz_period = KlazzPeriod.find(params[:id])
    render :edit, layout: false
  end
end