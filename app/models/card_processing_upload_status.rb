class CardProcessingUploadStatus
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :exam_date, :statuses

  def initialize(fullpath)
    @exam_date = (fullpath.gsub(/\/card_processing_upload_status\//, '')).to_date
    @statuses = []
    ExamExecution.where("datetime > '#{@exam_date}' and datetime < '#{@exam_date + 1}'").map(&:super_klazz).map(&:campus).uniq.each do |campus| 
      valid_card_processing_ids = CardProcessing.where(campus_id: campus.id, exam_date: @exam_date).map(&:id)
      status = []
      status[0] = campus.name
      status[1] = StudentExam.where(card_processing_id: valid_card_processing_ids).size
      status[2] = StudentExam.where(card_processing_id: valid_card_processing_ids, status: StudentExam::VALID_STATUS).size
      @statuses << status
    end
  end


end
