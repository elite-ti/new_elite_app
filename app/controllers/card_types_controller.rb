class CardTypesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def edit
  end

  def create
    if @card_type.save
      redirect_to card_types_url, notice: 'Card type was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @card_type.update_attributes(params[:card_type])
      redirect_to card_types_url, notice: 'Card type was successfully updated.'
    else
      render 'edit'
    end
  end
end
