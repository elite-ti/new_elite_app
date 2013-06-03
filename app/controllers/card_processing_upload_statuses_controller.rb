class CardProcessingUploadStatusesController < ApplicationController
  # load_and_authorize_resource

  def index
    @possible_dates = ExamExecution.all.map(&:datetime).map(&:to_date).uniq.sort!
  end
  
  def new
  end

  def create
    if @card_processing_upload_status.save
      redirect_to card_processing_upload_statuses_url, notice: 'Card processing upload status was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @card_processing_upload_status.update_attributes(params[:card_processing_upload_status])
      redirect_to card_processing_upload_statuses_url, notice: 'Card processing upload status was successfully updated.'
    else
      render 'edit'
    end
  end
end
