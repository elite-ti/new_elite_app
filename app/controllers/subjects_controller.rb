class SubjectsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def edit
  end

  def create
    if @subject.save
      redirect_to subjects_url, notice: 'Subject was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @subject.update_attributes(params[:subject])
      redirect_to subjects_url, notice: 'Subject was successfully updated.'
    else
      render 'edit'
    end
  end
end
