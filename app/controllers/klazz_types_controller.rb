class KlazzTypesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def edit
  end
  
  def create
    if @klazz_type.save
      redirect_to klazz_types_url, notice: 'Klazz type was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @klazz_type.update_attributes(params[:klazz_type])
      redirect_to klazz_types_url, notice: 'Klazz type was successfully updated.'
    else
      render 'edit'
    end
  end
end
