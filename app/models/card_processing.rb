require 'find'

class CardProcessing < ActiveRecord::Base
  has_paper_trail

  BEING_PROCESSED_STATUS = 'Being processed'
  PROCESSED_STATUS = 'Processed'
  ERROR_STATUS = 'Error'

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
    begin
      student_exams.each(&:scan)
      update_attribute :status, PROCESSED_STATUS
    rescue => e
      logger.warn e.message
      update_attribute :status, ERROR_STATUS
    end
  end

  def campuses
    campus_ids.split(',').map do |campus_id|
      Campus.find(campus_id)
    end
  end

  def processed?
    status == PROCESSED_STATUS
  end

private

  def decompress
    begin
      @folder_path = Decompressor.decompress(file.path, file.original_filename)
      self.status = BEING_PROCESSED_STATUS
      self.is_bolsao ||= false
    rescue => e
      logger.warn e.message
      errors.add(:file, 'error processing file')
    end
    true
  end

  def create_worker
    Find.find(@folder_path) do |path|
      next if File.directory?(path) || File.extname(path) != '.tif' 
      StudentExam.create!(card: File.open(path), card_processing_id: self.id)
    end
    true
  end
end
