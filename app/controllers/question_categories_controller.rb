class QuestionCategoriesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def edit
  end

  def create
    if @question_category.save
      redirect_to question_categories_url, notice: 'Question category was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @question_category.update_attributes(params[:question_category])
      redirect_to question_categories_url, notice: 'Question category was successfully updated.'
    else
      render 'edit'
    end
  end
end
