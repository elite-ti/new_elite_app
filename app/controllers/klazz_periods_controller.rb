class TimeTablesController < ApplicationController
  before_filter :new_klazz_period, only: :new
  load_and_authorize_resource
  around_filter :respond_to_js

  def new
  end

  def create
    @klazz_period.save!
    @klazz_period.reload
  end

  def edit
  end

  def update
    @klazz_period.update_attributes!(params[:klazz_period])
    @klazz_period.reload
  end

  def destroy
    @klazz_period.replicate = params[:replicate]
    @klazz_period.destroy
    render nothing: true
  end

private
  def new_klazz_period
    @klazz_period = TimeTable.new(position: params[:position], date: params[:date], klazz_id: params[:klazz_id])
  end

  def respond_to_js
    respond_to do |format| 
      format.js { yield } 
    end
  end
end
