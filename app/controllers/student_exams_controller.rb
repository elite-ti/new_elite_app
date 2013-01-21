class StudentExamsController < ApplicationController
  load_and_authorize_resource

  def index
    @student_exams_needing_check = StudentExam.needing_check
  end

  def new
  end

  def create
    if File.extname(params[:student_exam][:card].original_filename) != '.tif'
      decompress
      return
    end
    
    if @student_exam.save
      redirect_to student_exams_path, notice: 'Student exam was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @student_exam.update_attributes(params[:student_exam])
      if params[:commit] == 'Finish'
        finish_checking
      else
        check_student_exams
      end
    else
      render :edit
    end
  end

private

  def check_student_exams
    if StudentExam.any_needs_check?
      redirect_to edit_student_exam_path(StudentExam.needing_check.first), notice: 'Some fields need to be checked.'
    else
      finish_checking
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
      redirect_to student_exams_path, notice: 'Student exams were successfully created.'
    rescue Exception => e
      flash.now[:error] = e.message
      render :new
    end
  end

  def finish_checking
    redirect_to student_exams_path, notice: 'Student exam was successfully updated.'
  end
end