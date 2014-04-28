class ExamsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
  end

  def new
    @exam = Exam.new
    @exam.campus_ids = Campus.all.map(&:id)
    p @exam.campuses.map(&:name)
  end

  def edit
  end

  def create
    if @exam.save
      @exam.create_exam_executions(
        params[:exam][:campus_ids].reject! { |c| c.empty? }.map { |e| e.to_i },
        params[:exam][:product_year_ids].reject! { |c| c.empty? }.map { |e| e.to_i }
      )      
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
end
