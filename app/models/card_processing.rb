require 'find'

class CardProcessing < ActiveRecord::Base
  has_paper_trail

  BEING_PROCESSED_STATUS = 'Being processed'
  PROCESSED_STATUS = 'Processed'
  ERROR_STATUS = 'Error'

  belongs_to :card_type
  belongs_to :campus
  has_many :student_exams, dependent: :destroy

  attr_accessible :card_type_id, :file, :is_bolsao, 
    :exam_date, :campus_id, :status, :name
  attr_accessor :file

  validates :campus_id, :card_type_id,
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

  def processed?
    status == PROCESSED_STATUS
  end

  def needs_check?
    student_exams.needing_check.any?
  end

  def to_be_checked
    student_exams.needing_check.first
  end

  def total_number_of_cards
    student_exams.count
  end

  def number_of_errors
    student_exams.where(status: StudentExam::ERROR_STATUS).count
  end

private

  def decompress
    if file.present?
      begin
        @folder_path = Decompressor.decompress(file.path, file.original_filename)
        self.status = BEING_PROCESSED_STATUS
        self.is_bolsao ||= false
      rescue => e
        logger.warn '=> Error decompressing file'
        logger.warn e.message
        logger.warn "Folder path: #{@folder_path}"
        logger.warn "File path: #{file.path}"
        logger.warn "Filename: #{file.original_filename}"
        errors.add(:file, 'error decompressing file')
      end
    else
      errors.add(:file, 'can\' be blank')
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
