# encoding: UTF-8

class CardProcessingUploadStatusesController < ApplicationController
  # load_and_authorize_resource

  # def index
  #   @possible_dates = ExamExecution.all.map(&:datetime).map(&:to_date).uniq.sort!

  # end
  
  def index
    if params[:filter_by].nil?
      campus_ids = Campus.accessible_by(current_ability).map(&:id)
    elsif params[:filter_by] == "-1"
      campus_ids = Campus.all.map(&:id)
    else
      campus_ids = params[:filter_by].split(',').map(&:to_i)
    end
    
    @possible_dates = ExamExecution.where(super_klazz_id: SuperKlazz.where(campus_id: campus_ids), exam_cycle_id: ExamCycle.where(is_bolsao: true).map(&:id)).map(&:datetime).map(&:to_date).uniq.sort.reverse
    @exam_date = Date.parse(params[:exam_date] || ExamExecution.where(super_klazz_id: SuperKlazz.where(campus_id: campus_ids), exam_cycle_id: ExamCycle.where(is_bolsao: true).map(&:id)).map(&:datetime).map(&:to_date).map(&:to_s).uniq.max || '2001-01-01')

    if params[:group_by] == 'super_klazz' || params[:group_by].nil?
      # @exam_date = (request.fullpath.gsub(/\/card_processing_upload_status\//, '')).to_date
      @statuses = []
      @titles = ['Turma', 'Total de Cartões', 'Total de Cartões Válidos', 'Percentual']
      ExamExecution.where("datetime > '#{@exam_date}' and datetime < '#{@exam_date + 1}'").select{|ee| campus_ids.include?(ee.super_klazz.campus_id)}.uniq.each do |exam_execution|
        valid_card_processing_ids = CardProcessing.where(exam_execution_id: exam_execution.id).map(&:id)
        status = []
        status[0] = exam_execution.full_name
        status[1] = StudentExam.where(card_processing_id: valid_card_processing_ids).size
        status[2] = StudentExam.where(card_processing_id: valid_card_processing_ids, status: StudentExam::VALID_STATUS).size
        status[3] = (status[1] != 0 ? ("%.2f" % (100*status[2]/status[1])) : '0.00')
        @statuses << status
      end
    else
      # @exam_date = (request.fullpath.gsub(/\/card_processing_upload_status\//, '')).to_date
      @statuses = []
      @titles = ['Unidade', 'Total de Cartões', 'Total de Cartões Válidos', 'Percentual']
      campus_ids.map{|id| Campus.find(id)}.each do |campus| 
        valid_card_processing_ids = CardProcessing.where(campus_id: campus.id, exam_date: @exam_date).map(&:id)
        status = []
        status[0] = campus.name
        status[1] = StudentExam.where(card_processing_id: valid_card_processing_ids).size
        status[2] = StudentExam.where(card_processing_id: valid_card_processing_ids, status: StudentExam::VALID_STATUS).size
        status[3] = (status[1] != 0 ? ("%.2f" % (100*status[2]/status[1])) : '0.00')
        @statuses << status
      end
    end

  end
end
