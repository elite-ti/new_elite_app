class CardProcessingsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
  end

  def new
  end

  def create
    @card_processing.campus_ids = current_employee.send(current_role).accessible_campus_ids.join(',')
    if @card_processing.save
      CardProcessorWorker.perform_async(@card_processing.id)
      redirect_to card_processings_url, notice: 'Card processing was successfully created.'
    else
      debugger
      render :new
    end
  end

  def destroy
    @card_processing.destroy
    redirect_to card_processings_url, notice: 'Card processing was successfully destroyed.'
  end
end
