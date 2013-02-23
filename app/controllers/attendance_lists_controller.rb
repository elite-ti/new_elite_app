class AttendanceListsController < ApplicationController
  authorize_resource class: false

  def index
    respond_to do |format|
      format.xlsx do
        render xlsx: "index", disposition: "attachment", filename: "test.xlsx"
      end
    end
  end

  def new
  end

  def create
  end
end
