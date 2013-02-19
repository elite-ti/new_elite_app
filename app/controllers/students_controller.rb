class StudentsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
    @student.build_address
  end

  def edit
  end

  def create
    if @student.save
      redirect_to students_url, notice: 'Student was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @student.update_attributes(params[:student])
      redirect_to students_url, notice: 'Student was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @student.destroy
    redirect_to students_url, notice: 'Student was successfully destroyed.'
  end
end
