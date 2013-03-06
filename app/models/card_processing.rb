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

  validates :campus_id, :card_type_id, :file, :name,
    :exam_date, :status, presence: true

  before_validation :set_default_attributes, on: :create
  mount_uploader :file, CardProcessingUploader

  def processed?
    status == PROCESSED_STATUS
  end

  def being_processed?
    status == BEING_PROCESSED_STATUS
  end

  def error?
    status == ERROR_STATUS
  end

  def processed!
    update_attribute :status, PROCESSED_STATUS
  end 

  def error!
    update_attribute :status, ERROR_STATUS
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
    student_exams.where(status: StudentExam::ERROR_STATUS).count +
      student_exams.where(status: StudentExam::NEEDS_CHECK).count +
      student_exams.where(status: StudentExam::REPEATED_STUDENT).count
  end

  def remove_file!
  end
  
private

  def set_default_attributes
    self.status = BEING_PROCESSED_STATUS
    self.is_bolsao ||= false
    true
  end
end
