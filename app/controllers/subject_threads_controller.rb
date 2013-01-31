class SubjectThreadsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def edit
  end

  def create
    debugger
    if @subject_thread.save
      redirect_to subject_threads_url, notice: 'Subject thread was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @subject_thread.update_attributes(params[:subject_thread])
      redirect_to subject_threads_url, notice: 'Subject thread was successfully updated.'
    else
      render 'edit'
    end
  end
end
