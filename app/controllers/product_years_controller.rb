class ProductYearsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if @product_year.save
      redirect_to years_url, notice: 'Product year was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @product_year.update_attributes(params[:product_year])
      redirect_to years_url, notice: 'Product year was successfully updated.'
    else
      render 'edit'
    end
  end
end
