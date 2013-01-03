class PollPdfsController < ApplicationController
  load_and_authorize_resource

  def show
    respond_to do |format|
      format.pdf do
        send_data PollPdfPrawn.new(@poll_pdf).render, 
          filename: "#{@poll_pdf.poll.name}_#{@poll_pdf.klazz.name}.pdf",
          type: 'application/pdf',
          disposition: 'inline'
      end
    end
  end
end
