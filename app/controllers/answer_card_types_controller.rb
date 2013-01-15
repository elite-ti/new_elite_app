class AnswerCardTypesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def edit
  end

  def create
    if @answer_card_type.save
      redirect_to answer_card_types_url, notice: 'Answer card type was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @answer_card_type.update_attributes(params[:answer_card_type])
      redirect_to answer_card_types_url, notice: 'Answer card type was successfully updated.'
    else
      render 'edit'
    end
  end
end
