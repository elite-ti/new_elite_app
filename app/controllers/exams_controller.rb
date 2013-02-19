class ExamsController < ApplicationController
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
    if @exam.save
      redirect_to exams_url, notice: 'Exam was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @exam.update_attributes(params[:exam])
      redirect_to exams_url, notice: 'Exam was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @exam.destroy
    redirect_to exams_url, notice: 'Exam was successfully destroyed.'
  end
end
