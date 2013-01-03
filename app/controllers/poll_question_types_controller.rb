class PollQuestionTypesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def edit
  end

  def create
    if @poll_question_type.save
      redirect_to poll_question_types_url, notice: 'Poll question type was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @poll_question_type.update_attributes(params[:poll_question_type])
      redirect_to poll_question_types_url, notice: 'Poll question type was successfully updated.'
    else
      render 'edit'
    end
  end
end
