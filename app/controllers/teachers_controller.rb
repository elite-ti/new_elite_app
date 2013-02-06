class TeachersController < ApplicationController
  load_and_authorize_resource

  def show
    @date = (params[:date].nil? ? Date.today : Date.new(params[:date][:year].to_i, params[:date][:month].to_i, params[:date][:day].to_i))
    @klazz_periods = @teacher.find_absent_klazz_periods_by_date(@date)
  end

  # def update
  #   if @teacher.update_attributes(params[:teacher])
  #     redirect_to root_path, notice: 'Teacher was successfully updated.'
  #   else
  #     render 'schedule_infos/edit'
  #   end
  # end
end
