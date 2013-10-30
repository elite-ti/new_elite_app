#encoding: utf-8

class ScheduleInfosController < ApplicationController
  load_and_authorize_resource :teacher, parent: false

  def edit
    @teacher.build_product_group_preferences
  end

  def update
    if @teacher.update_attributes(params[:teacher])
      redirect_to root_path, notice: 'Pré-disponibilidade 2014 enviada com sucesso.'
    else
      render 'edit'
    end
  end
end
