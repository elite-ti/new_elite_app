#encoding: utf-8

class StudentsController < ApplicationController
  load_and_authorize_resource

  def index
    if !params[:is_bolsao].nil? && params[:is_bolsao] == 'true'
      @students = Applicant.all.map(&:student).uniq
      @is_bolsao = true
    else
      # @students = Student.select{|student| student.applied_super_klazzes.size == 0}
      @students = Student.all
      @is_bolsao = false      
    end
  end

  def new
    @student.build_address
    @is_bolsao = params[:is_bolsao] == 'true'
  end

  def edit
    @is_bolsao = params[:is_bolsao] == 'true'
  end

  def create
    if params[:student][:applied_super_klazz_ids][1] =~ /^[-+]?[0-9]+$/
      @student.number = @student.calculate_temporary_ra(params[:student][:applied_super_klazz_ids][1].to_i, 1)
      if @student.save
        redirect_to students_url(is_bolsao: !params[:student][:number].nil?), notice: (@is_bolsao? 'Candidato' : 'Aluno' ) + ' criado com sucesso.'
      else
        render 'new'
      end
    else
      @is_bolsao = !params[:student][:number].nil?
      flash[:notice] = 'Informe a turma na qual o aluno deseja cursar.'
      render 'new'
    end
  end

  def update
    @is_bolsao = @student.applicants.size > 0
    @student = Student.find(params[:id].to_i)
    @number = @student.number
    if @student.update_attributes(params[:student])
      @student.number = @number if !@number.nil?
      redirect_to students_url(is_bolsao: @is_bolsao), notice: 'Aluno editado com sucesso.'
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
    @is_bolsao = @student.applicants.size > 0
    @student.destroy
    redirect_to students_url(is_bolsao: @is_bolsao), notice: 'Aluno deletado com sucesso.'
  end
end
