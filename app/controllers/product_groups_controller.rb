class ProductGroupsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def edit
  end

  def create
    if @product_group.save
      redirect_to product_groups_url, notice: 'Product group was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @product_group.update_attributes(params[:product_group])
      redirect_to product_groups_url, notice: 'Product group was successfully updated.'
    else
      render 'edit'
    end
  end
end
