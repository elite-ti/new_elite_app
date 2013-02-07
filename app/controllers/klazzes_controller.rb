class KlazzesController < ApplicationController
  load_and_authorize_resource

  def index
    @klazzes = @klazzes.includes(:campus, year: {product: :product_type})
  end

  def show
  end

  def new
  end

  def create
    if @klazz.save
      redirect_to klazzes_url, notice: 'Klazz was successfully created.'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @klazz.update_attributes(params[:klazz])
      redirect_to klazzes_url, notice: 'Klazz was successfully updated.'
    else
      render 'edit'
    end
  end
end
