class QuestionTypesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def edit
  end

  def create
    if @question_type.save
      redirect_to question_types_url, notice: 'Question type was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @question_type.update_attributes(params[:question_type])
      redirect_to question_types_url, notice: 'Question type was successfully updated.'
    else
      render 'edit'
    end
  end
end
