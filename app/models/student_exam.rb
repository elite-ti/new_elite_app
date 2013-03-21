class StudentExam < ActiveRecord::Base
  has_paper_trail

  BEING_PROCESSED_STATUS = 'Being processed'
  ERROR_STATUS = 'Error'
  CUSTOM_ERROR_STATUS = 'Custom Error:'
  STUDENT_NOT_FOUND_STATUS = 'Student not found'
  EXAM_NOT_FOUND_STATUS = 'Exam not found'
  INVALID_ANSWERS_STATUS = 'Invalid answers'
  VALID_STATUS = 'Valid'
  REPEATED_STUDENT = 'Repeated student'
  NEEDS_CHECK = [STUDENT_NOT_FOUND_STATUS, EXAM_NOT_FOUND_STATUS, 
    INVALID_ANSWERS_STATUS, ERROR_STATUS, REPEATED_STUDENT]

  attr_accessible :card, :card_processing_id
  delegate :card_type, :is_bolsao, :exam_date, :campus, to: :card_processing

  belongs_to :exam_day
  belongs_to :student
  belongs_to :card_processing
  has_many :exam_answers, dependent: :destroy
  has_many :exam_questions, through: :exam_answers
  accepts_nested_attributes_for :exam_answers

  validates :card, :card_processing_id, presence: true

  mount_uploader :card, StudentExamCardUploader
  after_save :mark_conclicts!
  before_create :set_status_to_being_processed

  def self.needing_check
    where(status: NEEDS_CHECK)
  end

  def needs_check?
    NEEDS_CHECK.include? status
  end

  def possible_students
    if is_bolsao
      return campus.applicant_students
    else
      return campus.enrolled_students
    end
  end

  def possible_exam_days
    student.possible_exam_days(is_bolsao, exam_date)
  end

  def answers_needing_check
    exam_answers.select{ |ea| ea.need_to_be_checked? }
  end

  def student_not_found?
    status == STUDENT_NOT_FOUND_STATUS
  end

  def repeated_student?
    status == REPEATED_STUDENT
  end

  def exam_not_found?
    status == EXAM_NOT_FOUND_STATUS
  end

  def invalid_answers?
    status == INVALID_ANSWERS_STATUS
  end

  def error?
    status == ERROR_STATUS
  end

  def custom_error?
    status.match(/\ACustom Error:/)
  end

  def custom_error!(message)
    update_attribute :status, CUSTOM_ERROR_STATUS + ' ' + message
  end

  def scan
    begin
      self.student_number, self.string_of_answers = 
        card_type.scan(card.png.path, card.normalized_path) 
      set_student
      save!
    rescue => e
      logger.warn e.message
      update_attribute :status, ERROR_STATUS
    end
  end

  def set_student
    normalized_student_number = student_number.gsub(/\AZ*/, '').gsub(/Z*\z/, '')
    if is_bolsao
      student = Applicant.where(number: normalized_student_number.to_i).first.try(:student)
    else
      student = Student.where(ra: normalized_student_number.to_i).first
    end

    if student and possible_students.include?(student) 
      self.student_id = student.id 
      set_exam_day
    else
      self.status = STUDENT_NOT_FOUND_STATUS
    end
  end

  def set_exam_day
    exam_days = possible_exam_days
    if exam_days.present? and exam_days.size == 1
      self.exam_day_id = exam_days.first.id
      set_exam_answers
    else
      self.status = EXAM_NOT_FOUND_STATUS
    end
  end 

  def set_exam_answers
    exam_answers.destroy_all
    exam_day.super_exam.number_of_questions.times do |i|      
      string_of_answers[i] ||= 'Z'
      exam_answers.build(answer: string_of_answers[i])
    end

    if answers_needing_check.any?
      self.status = INVALID_ANSWERS_STATUS
    else
      self.status = VALID_STATUS
    end
  end

  def get_exam_answers
    exam_answers.includes(:exam_question).sort do |x,y| 
      x.exam_question.number <=> y.exam_question.number 
    end.map(&:answer)
  end

  def remove_card!
  end

private

  def set_status_to_being_processed
    self.status = BEING_PROCESSED_STATUS
    true
  end

  def mark_conclicts!
    if student.present? and exam_day.present?
      conflicts = StudentExam.where(
        student_id: student.id, 
        exam_day_id: exam_day.id)
      if conflicts.size > 1
        conflicts.each do |student_exam|
          next if student_exam.id == self.id
          
          if `diff #{student_exam.card.path} #{self.card.path}`.present?
            student_exam.update_column :status, REPEATED_STUDENT
            self.update_column :status, REPEATED_STUDENT
          else
            student_exam.destroy
          end
        end
      end
    end
    true
  end
end
