class ExamCyclesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def edit
  end

  def create
    if @exam_cycle.save
      redirect_to exam_cycles_url, notice: 'Exam cycle was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @exam_cycle.update_attributes(params[:exam_cycle])
      redirect_to exam_cycles_url, notice: 'Exam cycle was successfully updated.'
    else
      render 'edit'
    end
  end
end
