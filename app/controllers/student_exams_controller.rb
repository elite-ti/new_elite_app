class StudentExamsController < ApplicationController
  load_and_authorize_resource

  def new
  end

  def create
    @student_exam.scan_card(params[:student_exam][:card].path)
    if @student_exam.save
      redirect_to root_url, notice: 'Student exam was successfully created.'
    else
      render 'new'
    end
  end

  # def create
  #   @exam_id = params[:student_exam][:exam_id]
  #   file = params[:file]
  #   file_path = File.path file.tempfile
  #   extension = File.extname(file.original_filename)

  #   if extension == '.tif'
  #     scan_file(file_path)
  #   elsif extension.in? Uncompressor.supported_extensions
  #     uncompressor = Uncompressor.new(file_path)
  #     uncompressor.get_files.each { |f| scan_file(f) }
  #     uncompressor.destroy_files
  #   else
  #     flash.now[:error] = 'File extension not supported.'
  #     render :new
  #   end
  # end
end