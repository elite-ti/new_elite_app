class TimeTablesController < ApplicationController
  before_filter :new_time_table, only: :new
  load_and_authorize_resource
  around_filter :respond_to_js

  def new
  end

  def create
    @time_table.save!
    @time_table.reload
  end

  def edit
  end

  def update
    @time_table.update_attributes!(params[:time_table])
    @time_table.reload
  end

  def destroy
    @time_table.replicate = params[:replicate]
    @time_table.destroy
    render nothing: true
  end

private
  def new_time_table
    @time_table = TimeTable.new(position: params[:position], date: params[:date], klazz_id: params[:klazz_id])
  end

  def respond_to_js
    respond_to do |format| 
      format.js { yield } 
    end
  end
end
