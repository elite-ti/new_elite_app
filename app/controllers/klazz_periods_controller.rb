class KlazzPeriodsController < ApplicationController
  load_and_authorize_resource :klazz
  load_and_authorize_resource :period, through: :klazz
  
  layout false

  def index
    set_week
  end

  def new
  end

  def create
    if @period.save
      render partial: 'klazz_period/period', locals: { period: @period }
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @period.update_attributes(params[:period])
      render partial: 'klazz_period/period', locals: { period: @period }
    else
      render :edit
    end
  end

  def destroy
    @period.destroy
    head 200
  end

private

  def set_week
    monday = (params[:date] ? Date.parse(params[:date]) : Date.current).beginning_of_week
    @week = monday..(monday + 5.days)
  end
end