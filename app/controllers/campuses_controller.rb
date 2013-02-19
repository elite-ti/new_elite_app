class CampusesController < ApplicationController
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
    if @campus.save
      redirect_to campuses_url, notice: 'Campus was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @campus.update_attributes(params[:campus])
      redirect_to campuses_url, notice: 'Campus was successfully updated.'
    else
      render 'edit'
    end
  end
end
