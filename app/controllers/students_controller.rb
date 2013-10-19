#encoding: utf-8

class StudentsController < ApplicationController
  load_and_authorize_resource

  def index
    if !params[:is_bolsao].nil? && params[:is_bolsao] == 'true'
      super_klazz_ids = SuperKlazz.where(campus_id: Campus.accessible_by(current_ability).map(&:id))
      @students = Applicant.where(super_klazz_id: super_klazz_ids).includes(:student => :applicants).map(&:student).compact.uniq
      # @students = Applicant.where(super_klazz_id: super_klazz_ids).includes(:student => {:applicants => {:super_klazz => [:campus, :product_year] }}).map(&:student).compact.uniq
      @is_bolsao = true
    else
      # @students = Student.select{|student| student.applied_super_klazzes.size == 0}
      @students = Student.all
      @is_bolsao = false      
    end
  end

  def show
    @is_bolsao = @student.applicants.size > 0
  end

  def new
    @is_bolsao = params[:is_bolsao] == 'true'
    @student.build_address
    if @is_bolsao
      @accessible_super_klazzes = SuperKlazz.where(campus_id: Campus.accessible_by(current_ability, product_year_id: Year.find_by_number(2014).product_years.map(&:id)).map(&:id))
    else
      @accessible_super_klazzes = SuperKlazz.where(campus_id: Campus.accessible_by(current_ability).map(&:id))
    end
  end

  def edit
    @is_bolsao = params[:is_bolsao] == 'true'
    if @is_bolsao
      @accessible_super_klazzes = SuperKlazz.where(campus_id: Campus.accessible_by(current_ability, product_year_id: Year.find_by_number(2014).product_years.map(&:id)).map(&:id))
    else
      @accessible_super_klazzes = SuperKlazz.where(campus_id: Campus.accessible_by(current_ability).map(&:id))
    end
  end

  def create
    p 'Bolsao: ' + params[:student][:number].to_s
    @is_bolsao = !params[:student][:number].nil?
    if @is_bolsao && !(params[:student][:applied_super_klazz_ids][1] =~ /^[-+]?[0-9]+$/)
      flash[:notice] = 'Informe a turma na qual o aluno deseja cursar.'
      render 'new'
    else
      if @is_bolsao
        if params[:student][:number] == "-1"
          @student.number = @student.calculate_temporary_number(params[:student][:applied_super_klazz_ids][1].to_i, 1)
        else
          @student.number = params[:student][:number]
        end
      end
      if @student.save
        if @is_bolsao
          redirect_to student_url(@student, is_bolsao: true), notice: 'Candidato criado com sucesso.'
        else
          redirect_to students_url(), notice: 'Aluno criado com sucesso.'
        end
      else
        render 'new'
      end
    end
  end

  def update
    @is_bolsao = @student.applicants.size > 0
    # @student.number = params[:student][:number]    
    @student = Student.find(params[:id].to_i)
    @number = @student.number
    if @student.update_attributes(params[:student])
      p '============'
      p @number
      if @is_bolsao && !params[:student][:number].nil? && params[:student][:number] =~ /^[-+]?[0-9]+$/
          @student.number = params[:student][:number]
      end
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
