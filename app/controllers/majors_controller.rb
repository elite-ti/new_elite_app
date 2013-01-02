class MajorsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def edit
  end

  def create
    if @major.save
      redirect_to majors_url, notice: 'Major was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @major.update_attributes(params[:major])
      redirect_to majors_url, notice: 'Major was successfully updated.'
    else
      render 'edit'
    end
  end
end
