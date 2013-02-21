class CardProcessingsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
  end

  def new
    @accessible_campuses = Campus.accessible_by(current_ability)
    @campus_field_value = @accessible_campuses.first.id if @accessible_campuses.size == 1
  end

  def create
    if @card_processing.save
      CardProcessorWorker.perform_async(@card_processing.id)
      redirect_to card_processings_url, notice: 'Card processing was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @card_processing.destroy
    redirect_to card_processings_url, notice: 'Card processing was successfully destroyed.'
  end
end
