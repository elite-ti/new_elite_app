class PollsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
    @poll = Poll.includes(poll_pdfs: [:klazz, :poll_answers]).find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        send_data @poll.generate_zipfile, 
          filename: "#{@poll.name}_all.zip",
          type: 'application/zip',
          disposition: 'attachment'
      end
    end
  end

  def new
  end

  def create
    if @poll.save
      redirect_to polls_url, notice: 'Poll was successfully created.'
    else
      render 'new'
    end
  end

  def update
    dat_file = params[:poll][:dat_file]
    klazz_or_error = @poll.find_klazz(dat_file.original_filename)

    if klazz_or_error.class == Klazz
      @poll.update_answers klazz_or_error, dat_file.read
      redirect_to @poll, notice: 'Answers updated.'
    else
      flash.now[:error] = klazz_or_error
      render :show
    end
  end
end
