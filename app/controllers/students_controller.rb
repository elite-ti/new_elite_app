#encoding: utf-8

class StudentsController < ApplicationController
  load_and_authorize_resource

  def index
      @students = Student.where("ra IS NOT NULL")
  end

  def import
    p params[:file].tempfile.path
    # Student.import(params[:file].tempfile)
    StudentCsvImportWorker.perform_async(params[:file].tempfile.path, current_employee.email)
    redirect_to root_url, notice: "Alunos importados com sucesso."
  end

  def show
  end

  def new
    @student.build_address
    @accessible_super_klazzes = SuperKlazz.where(product_year_id: Year.find_by_number((Date.today + 6.months).year).product_years.map(&:id), campus_id: Campus.accessible_by(current_ability).map(&:id))
  end

  def edit
    @accessible_super_klazzes = SuperKlazz.where(product_year_id: Year.find_by_number((Date.today + 6.months).year).product_years.map(&:id), campus_id: Campus.accessible_by(current_ability).map(&:id))
  end

  def create    
    if @student.save
      redirect_to students_url(@student).gsub(/(\/students\.)/,"/students/"), notice: 'Aluno criado com sucesso.'
    else
      render 'new'
    end
  end

  def update
    if @student.update_attributes(params[:student])
        redirect_to students_url(@student).gsub(/(\/students\.)/,"/students/"), notice: 'Aluno editado com sucesso.'
    else
      render 'edit'
    end
  end

  def fix_ra
    @student = Student.find(params[:id])
    @student.fix_temporary_student(params[:new_ra])
    new_student = Student.find_by_ra(params[:new_ra])
    redirect_to edit_student_path(new_student), notice: 'Aluno temporário editado com sucesso.'
  end

  def destroy
    @student.destroy
    redirect_to students_url(is_bolsao: @is_bolsao), notice: 'Aluno deletado com sucesso.'
  end

end
