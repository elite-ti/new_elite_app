class YearsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if @year.save
      redirect_to years_url, notice: 'Year was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @year.update_attributes(params[:year])
      redirect_to years_url, notice: 'Year was successfully updated.'
    else
      render 'edit'
    end
  end
end
