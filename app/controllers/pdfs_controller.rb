class PdfsController < ApplicationController
  load_and_authorize_resource

  def show
    respond_to do |format|
      format.pdf do
        send_data PollPdf.new(@pdf).render, 
          filename: "#{@pdf.poll.name}_#{@pdf.klazz.name}.pdf",
          type: 'application/pdf',
          disposition: 'inline'
      end
    end
  end
end
