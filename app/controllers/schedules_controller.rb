class SchedulesController < ApplicationController
  authorize_resource

  def show
    schedule = Schedule.new(params[:schedule])
    respond_to do |format|
      format.js
    end
  end

  def create
  end

  def update
  end
end 