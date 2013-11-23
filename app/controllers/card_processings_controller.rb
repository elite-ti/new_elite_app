#encoding: utf-8

class CardProcessingsController < ApplicationController
  load_and_authorize_resource

  def index
    # @card_processings = @card_processings || CardProcessing.includes(:campus, :card_type, :student_exams)
    respond_to do |format|
      format.html
      format.json { render json: CardProcessingsDatatable.new(view_context)}
    end
  end

  def show
    @translations = {'Being processed' => 'Em processamento', 'Error' => 'Erro', 'Student not found' => 'Aluno não encontrado', 'Exam not found' => 'Prova não encontrada', 'Invalid answers' => 'Respostas inválidas', 'Valid' => 'Válido', 'Repeated student' => 'Aluno Repetido'}
  end

  def new
    if(params[:exam_execution_id].present?)
      @specific_exam = true
      @exam_execution = ExamExecution.find(params[:exam_execution_id])
    end
    set_campus_select
  end

  def create
    if @card_processing.save
      email = current_employee.email.present? ? current_employee.email : 'elitesim@sistemaeliterio.com.br'
      CardProcessorWorker.perform_async(@card_processing.id, email)
      if @card_processing.try(:exam_execution).try(:exam_cycle).try(:is_bolsao) || false
        redirect_to exam_executions_url(filter_by: 'is_bolsao'), notice: 'Cartões enviados com sucesso.'
      else
        redirect_to card_processings_url, notice: 'Cartões enviados com sucesso.'
      end
    else
      set_campus_select
      render :new
    end
  end

  def destroy
    @card_processing.destroy
    redirect_to card_processings_url, notice: 'Card processing was successfully destroyed.'
  end

private

  def set_campus_select
    @accessible_campuses = Campus.accessible_by(current_ability)
    @campus_include_blank = !(@accessible_campuses.size == 1)
  end
end
