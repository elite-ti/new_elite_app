class QuestionsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
    @question.options.build
  end

  def create
    if @question.save
      redirect_to questions_url, notice: 'Question was successfully created.'
    else
      render 'new'
    end
  end

  def edit
    @question.options.build if @question.options.empty?
  end

  def update
    if @question.update_attributes(params[:question])
      redirect_to questions_url, notice: 'Question was successfully updated.'
    else
      render 'edit'
    end
  end
end
