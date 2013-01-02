class ProductTypesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def edit
  end

  def create
    if @product_type.save
      redirect_to product_type_url, notice: 'Product type was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @product_type.update_attributes(params[:product_type])
      redirect_to product_type_url, notice: 'Product type was successfully updated.'
    else
      render 'edit'
    end
  end
end
