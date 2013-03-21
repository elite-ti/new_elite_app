class SuperExamsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
    create_exam_if_none
  end

  def edit
    create_exam_if_none
  end

  def create
    if @super_exam.save
      redirect_to super_exams_url, notice: 'Super exam was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @super_exam.update_attributes(params[:super_exam])
      redirect_to super_exams_url, notice: 'Super exam was successfully updated.'
    else
      render 'edit'
    end
  end

private

  def create_exam_if_none
    @super_exam.exams.build if @super_exam.exams.empty?
  end
end
