class AbsenceReasonsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def edit
  end

  def create
    if @absence_reason.save
      redirect_to absence_reasons_url, notice: 'Absence reason was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @absence_reason.update_attributes(params[:absence_reason])
      redirect_to absence_reasons_url, notice: 'Absence reason was successfully updated.'
    else
      render 'edit'
    end
  end
end
