class TopicsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def edit
  end

  def create
    if @topic.save
      redirect_to topics_url, notice: 'Topic was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @topic.update_attributes(params[:topic])
      redirect_to topics_url, notice: 'Topic was successfully updated.'
    else
      render 'edit'
    end
  end
end
