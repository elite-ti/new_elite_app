require 'find'

class CardProcessing < ActiveRecord::Base
  has_paper_trail

  BEING_PROCESSED_STATUS = 'Being processed'
  PROCESSED_STATUS = 'Processed'

  belongs_to :card_type
  has_many :student_exams, dependent: :destroy

  attr_accessible :card_type_id, :file, :is_bolsao, 
    :exam_date, :campus_ids, :status
  attr_accessor :file

  validates :campus_ids, :card_type_id,
    :exam_date, :status, presence: true

  before_validation :decompress
  after_create :create_worker

  def scan
    student_exams.each do |student_exam|
      student_exam.scan
    end
    update_attribute :status, PROCESSED_STATUS
  end

  def campuses
    campuses_ids.split(',').map do |campus_id|
      Campus.find(campus_id)
    end
  end

private

  def decompress
    begin
      @folder_path = Decompressor.decompress(file.path, file.original_filename)
      self.status = BEING_PROCESSED_STATUS
      self.is_bolsao ||= false
    rescue
      errors.add(:file, 'error processing file')
    end
    nil
  end

  def create_worker
    Find.find(@folder_path) do |path|
      next if File.directory?(path) || File.extname(path) != '.tif' 
      StudentExam.create!(card: File.open(path), card_processing_id: self.id)
    end
    CardProcessorWorker.perform_async(self.id)
    nil
  end
end
