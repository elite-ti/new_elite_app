class StudentExamsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
  end

  def edit
  end

  def update
    p = params[:student_exam]
    if @student_exam.set_user_modifications(p[:student_id], p[:exam_answers_attributes])
      if params[:commit] == 'Finish'
        redirect_to student_exams_path, notice: 'Changes applied!'
      else
        check_student_exams
      end
    else
      render :edit
    end
  end

private

  def check_student_exams
    if StudentExam.needing_check.any?
      redirect_to edit_student_exam_path(StudentExam.needing_check.first), 
        notice: 'Some fields need to be checked.'
    else
      redirect_to student_exams_path, notice: 'All cards were checked!'
    end
  end
end
