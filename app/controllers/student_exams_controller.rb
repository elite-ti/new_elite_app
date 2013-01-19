class StudentExamsController < ApplicationController
  load_and_authorize_resource

  def new
  end

  def create
    if @student_exam.save
      check_student_exam
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @student_exam.update_attributes(params[:student_exam])
      check_student_exam
    else
      render :edit
    end
  end

private

  def check_student_exam
    if @student_exam.needs_check?
      redirect_to edit_student_exam_path(@student_exam), notice: 'Some errors scanning card.'
    else
      redirect_to root_url, notice: 'Student exam was successfully created.'
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