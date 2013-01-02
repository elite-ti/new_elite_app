class EliteRolesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def edit
  end

  def create
    if @elite_role.save
      redirect_to elite_roles_url, notice: 'Elite role was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @elite_role.update_attributes(params[:elite_role])
      redirect_to elite_roles_url, notice: 'Elite role was successfully updated.'
    else
      render 'edit'
    end
  end
end
