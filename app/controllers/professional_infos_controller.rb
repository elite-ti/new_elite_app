#encoding: utf-8

class ProfessionalInfosController < ApplicationController
  load_and_authorize_resource :teacher, parent: false

  def edit
    build_professional_experiences
  end

  def update
    params["teacher"].keys.each do |key| 
      params["teacher"][key] = true if params["teacher"][key] == 'Sim'
      params["teacher"][key] = false if params["teacher"][key] == 'Não'
    end
    if @teacher.update_attributes(params[:teacher])
      redirect_to edit_schedule_info_path(@teacher), notice: 'Informações Profissionais atualizadas com sucesso.'
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
