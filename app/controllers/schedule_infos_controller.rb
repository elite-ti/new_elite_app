class ScheduleInfosController < ApplicationController
  load_and_authorize_resource :teacher, parent: false

  def edit
    @teacher.build_product_group_preferences
  end

  def update
    if @teacher.update_attributes(params[:teacher])
      redirect_to root_path, notice: 'Schedule info was successfully updated.'
    else
      render 'edit'
    end
  end
end
