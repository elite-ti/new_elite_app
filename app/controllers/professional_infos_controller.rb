class ProfessionalInfosController < ApplicationController
  load_and_authorize_resource :teacher, parent: false

  def edit
    build_professional_experiences
  end

  def update
    if @teacher.update_attributes(params[:teacher])
      redirect_to edit_schedule_info_path(@teacher), notice: 'Professional info was successfully updated.'
    else
      build_professional_experiences
      render 'edit'
    end
  end

private

  def build_professional_experiences
    @teacher.professional_experiences.build if @teacher.professional_experiences.empty?
  end
end
