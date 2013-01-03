class PollQuestionCategoriesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def edit
  end

  def create
    if @poll_question_category.save
      redirect_to poll_question_categories_url, notice: 'Poll question category was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @poll_question_category.update_attributes(params[:poll_question_category])
      redirect_to poll_question_categories_url, notice: 'Poll question category was successfully updated.'
    else
      render 'edit'
    end
  end
end
