class PeriodsController < ApplicationController
  load_and_authorize_resource :klazz
  load_and_authorize_resource :period, through: :klazz
  
  layout false

  def index
    @week = set_week
  end

  def new
  end

  def create
    if @period.save
      render partial: 'period', locals: { period: @period }
    else
      render :new, layout: false
    end
  end

  def edit
  end

  def update
    if @period.update_attributes(params[:period])
      render partial: 'period', locals: { period: @period }
    else
      render :edit, layout: false
    end
  end

  def destroy
    @period.destroy
  end

private

  def set_week
    monday = (params[:date] ? Date.parse(params[:date]) : Date.current).beginning_of_week
    monday..(monday + 5.days)
  end
end