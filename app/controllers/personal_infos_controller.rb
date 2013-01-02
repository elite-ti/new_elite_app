class PersonalInfosController < ApplicationController
  load_and_authorize_resource :employee, parent: false

  def edit
  end

  def update
    if @employee.update_attributes(params[:employee])
      redirect_to edit_professional_info_path(@employee.teacher), notice: 'Personal info was successfully updated.'
    else
      render 'edit'
    end
  end
end
