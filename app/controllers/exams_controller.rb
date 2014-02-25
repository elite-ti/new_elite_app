class ExamsController < ApplicationController
  load_and_authorize_resource

  def index
    is_bolsao = [true, false] if params[:is_bolsao].nil?
    is_bolsao = (params[:filter_by] == 'true' ? true : false) if params[:is_bolsao].present?

    @exams = Exam.where(id: ExamExecution.where(
      super_klazz_id: SuperKlazz.where(campus_id: Campus.accessible_by(current_ability).map(&:id)), 
      exam_cycle_id: ExamCycle.where(is_bolsao: is_bolsao, product_year_id: ProductYear.where(year_id: Year.last.id))
    ).map(&:exam_id).uniq)
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if @exam.save
      redirect_to exams_url, notice: 'Exam was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @exam.update_attributes(params[:exam])
      redirect_to exams_url, notice: 'Exam was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @exam.destroy
    redirect_to exams_url, notice: 'Exam was successfully destroyed.'
  end

  def import
    ExamCsvImportWorker.perform_async(params[:file].tempfile.path, current_employee.email)
    redirect_to root_url, notice: "Provas importadas com sucesso."    
  end

  def result
    exam_execution_ids = @exam.exam_execution_ids
    @student_exams = StudentExam.where(status: StudentExam::VALID_STATUS, exam_execution_id: exam_execution_ids).includes({:card_processing => :campus}, :student)
    @subjects = @exam.exam_questions.includes(:question => {:topics => :subject}).map(&:question).map(&:topics).map(&:first).map(&:subject).group_by{|a| a}.map{|a, b| [a, b.size]}
    @has_errors = @exam.exam_executions.map(&:needs_check?).select{|a| a}.any?
  end

end
