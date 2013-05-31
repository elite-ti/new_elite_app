class CardProcessingsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
    respond_to do |format|
      format.html
      format.xlsx {send_file @card_processing.create_file, :type=>"application/xlsx", :x_sendfile=>true}
    end
  end

  def new
    set_campus_select
  end

  def create
    if @card_processing.save
      CardProcessorWorker.perform_async(@card_processing.id)
      redirect_to card_processings_url, notice: 'Card processing was successfully created.'
    else
      set_campus_select
      render :new
    end
  end

  def destroy
    @card_processing.destroy
    redirect_to card_processings_url, notice: 'Card processing was successfully destroyed.'
  end

private

  def set_campus_select
    @accessible_campuses = Campus.accessible_by(current_ability)
    @campus_include_blank = !(@accessible_campuses.size == 1)
  end
end
