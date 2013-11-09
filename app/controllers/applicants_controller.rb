#encoding: utf-8

class ApplicantsController < ApplicationController
  # load_and_authorize_resource

  def index
    
    if !params[:exam_date].nil?
      date = Date.parse(params[:exam_date]  || ExamExecution.where(super_klazz_id: SuperKlazz.where(campus_id: Campus.accessible_by(current_ability).map(&:id)), exam_cycle_id: ExamCycle.where(is_bolsao: true).map(&:id)).map(&:datetime).map(&:to_date).uniq.max.to_s)
      @applicants = Applicant.where(exam_campus_id: Campus.accessible_by(current_ability).map(&:id),exam_datetime: (date.beginning_of_day..date.end_of_day)).includes(:student => :applicants)      
    else
      @applicants = []
    end
  end

  def show
  end

  def new
    @applicant = Applicant.new
    @applicant.build_student
    # build_student
    @accessible_super_klazzes = SuperKlazz.where(campus_id: Campus.accessible_by(current_ability).map(&:id))
    respond_to do |format|
      format.html { render "applicants/new", :layout => false  } 
    end
  end

  def edit
    @accessible_super_klazzes = SuperKlazz.where(campus_id: Campus.accessible_by(current_ability).map(&:id))
  end

  def create
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
          redirect_to students_url(@student).gsub(/(\/students\.)/,"/students/"), notice: 'Aluno criado com sucesso.'
        end
      else
        render 'new'
      end
    end
  end

  def update
    if @applicant.update_attributes(params[:applicant])
      redirect_to applicants_url, notice: 'Candidato editado com sucesso.'
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

private

  # def build_student
  #   @applicant.student.build if @applicant.student.nil?
  # end
end
