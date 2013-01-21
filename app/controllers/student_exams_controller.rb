class StudentExamsController < ApplicationController
  load_and_authorize_resource

  def new
  end

  def create
    if File.extname(params[:student_exam][:card].original_filename) != '.tif'
      decompress
      return
    end
    
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

  def decompress
    begin
      file_path = params[:student_exam][:card].tempfile.path
      extension = File.extname(params[:student_exam][:card].original_filename)
      Decompressor.process_files(file_path, extension) do |file|
        @student_exam = StudentExam.create!(
          exam_id: params[:student_exam][:exam_id],
          answer_card_type_id: params[:student_exam][:answer_card_type_id],
          card: File.open(file)
        )
      end
      redirect_to root_url, notice: 'Student exams were successfully created.'
    rescue Exception => e
      flash.now[:error] = e.message
      render :new
    end
  end
end