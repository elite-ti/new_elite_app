class KlazzesController < ApplicationController
  load_and_authorize_resource

  def index
    @klazzes = @klazzes.includes(:campus, product_year: { product: :product_type })
  end

  def show
    respond_to do |format|
      format.html
      format.xls do
        headers["Content-Disposition"] = "attachment; filename=\"#{@klazz.name}.xls\"" 
      end
    end
  end

  def new
  end

  def create
    if @klazz.save
      redirect_to @klazz, notice: 'Klazz was successfully created.'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @klazz.update_attributes(params[:klazz])
      redirect_to @klazz, notice: 'Klazz was successfully updated.'
    else
      render 'edit'
    end
  end
end
