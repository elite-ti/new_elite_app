class StudentsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
    @student.build_address
  end

  def edit
  end

  def create
    if @student.save
      redirect_to students_url, notice: 'Student was successfully created.'
    else
      render 'new'
    end
  end

  def update
    @student = Student.find(params[:id].to_i)
    if(@student.ra != params[:student][:ra])
      @student.fix_temporary_student(params[:student][:ra])      
      new_student = Student.find_by_ra(params[:student][:ra])
      redirect_to edit_student_path(new_student), notice: 'Temporary Student was fixed.'
    else
      if @student.update_attributes(params[:student])
        redirect_to students_url, notice: 'Student was successfully updated.'
      else
        render 'edit'
      end      
    end
  end

  def fix_ra
    PARE
    @student = Student.find(params[:id])
    @student.fix_temporary_student(params[:new_ra])
    new_student = Student.find_by_ra(params[:new_ra])
    redirect_to edit_student_path(new_student), notice: 'Temporary Student was fixed.'
  end

  def destroy
    @student.destroy
    redirect_to students_url, notice: 'Student was successfully destroyed.'
  end
end
