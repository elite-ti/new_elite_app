# encoding: UTF-8

class CardProcessingUploadStatus
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :exam_date, :statuses, :titles

  def initialize(fullpath, filter_by=nil)
    if filter_by == 'super_klazz'
      @exam_date = (fullpath.gsub(/\/card_processing_upload_status\//, '')).to_date
      @statuses = []
      @titles = ['Turma', 'Total de Cartões', 'Total de Cartões Válidos', 'Percentual']
      ExamExecution.where("datetime > '#{@exam_date}' and datetime < '#{@exam_date + 1}'").uniq.each do |exam_execution| 
        valid_card_processing_ids = CardProcessing.where(exam_execution_id: exam_execution.id).map(&:id)
        status = []
        status[0] = exam_execution.full_name
        status[1] = StudentExam.where(card_processing_id: valid_card_processing_ids).size
        status[2] = StudentExam.where(card_processing_id: valid_card_processing_ids, status: StudentExam::VALID_STATUS).size
        status[3] = (status[1] != 0 ? ("" % 100*status[2]/status[1]) : 0)
        @statuses << status
      end
    else
      @exam_date = (fullpath.gsub(/\/card_processing_upload_status\//, '')).to_date
      @statuses = []
      @titles = ['Unidade', 'Total de Cartões', 'Total de Cartões Válidos', 'Percentual']
      ExamExecution.where("datetime > '#{@exam_date}' and datetime < '#{@exam_date + 1}'").map(&:super_klazz).map(&:campus).uniq.each do |campus| 
        valid_card_processing_ids = CardProcessing.where(campus_id: campus.id, exam_date: @exam_date).map(&:id)
        status = []
        status[0] = campus.name
        status[1] = StudentExam.where(card_processing_id: valid_card_processing_ids).size
        status[2] = StudentExam.where(card_processing_id: valid_card_processing_ids, status: StudentExam::VALID_STATUS).size
        status[3] = (status[1] != 0 ? ("" % 100*status[2]/status[1]) : 0)
        @statuses << status
      end
    end
  end


end
