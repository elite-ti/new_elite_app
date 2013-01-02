class <%= plural_table_name.camelize %>Controller < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def edit
  end

  def create
    if @<%= singular_table_name %>.save
      redirect_to <%= plural_table_name %>_url, notice: '<%= singular_table_name.humanize %> was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @<%= singular_table_name %>.update_attributes(params[:<%= singular_table_name %>])
      redirect_to <%= plural_table_name %>_url, notice: '<%= singular_table_name.humanize %> was successfully updated.'
    else
      render 'edit'
    end
  end
end
