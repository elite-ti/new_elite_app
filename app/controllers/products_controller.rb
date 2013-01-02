class ProductsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def edit
  end

  def create
    if @product.save
      redirect_to products_url, notice: 'Product was successfully created.'
    else
      render 'new' 
    end
  end

  def update
    if @product.update_attributes(params[:product])
      redirect_to products_url, notice: 'Product was successfully updated.'
    else
      render 'edit'
    end
  end
end
