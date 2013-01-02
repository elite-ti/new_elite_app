class SchoolRolesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def edit
  end

  def create
    if @school_role.save
      redirect_to school_roles_url, notice: 'School role was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @school_role.update_attributes(params[:school_role])
      redirect_to school_roles_url, notice: 'School role was successfully updated.'
    else
      render 'edit'
    end
  end
end
