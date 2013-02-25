class SuperKlazzesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
    if @super_klazz.save
      redirect_to super_klazzes_path, notice: 'Super klazz was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @super_klazz.update_attributes(params[:super_klazz])
      redirect_to super_klazzes_path, notice: 'Super klazz was successfully updated.'
    else
      render :edit
    end
  end
end
