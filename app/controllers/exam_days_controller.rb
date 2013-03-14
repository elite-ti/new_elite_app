class ExamDaysController < ApplicationController
  authorize_resource
  load_resource except: [:new, :create]

  def index
  end

  def new
    @exam_day_form = ExamDayForm.new
  end

  def create
    @exam_day_form = ExamDayForm.new(params[:exam_day_form])

    if @exam_day_form.save
      redirect_to exam_days_url, notice: 'Exam day was successfully created.'
    else
      flash.now[:notice] = @exam_day_form.unknown_error
      render 'new'
    end
  end

  def edit
  end

  def update
    if @exam_day.update_attributes(params[:exam_day])
      redirect_to exam_days_url, notice: 'Exam day was successfully updated.'
    else
      render 'edit'
    end
  end
end
