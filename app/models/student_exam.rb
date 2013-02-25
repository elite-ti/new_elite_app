class StudentExam < ActiveRecord::Base
  has_paper_trail

  BEING_PROCESSED_STATUS = 'Being processed'
  ERROR_STATUS = 'Error'
  STUDENT_NOT_FOUND_STATUS = 'Student not found'
  EXAM_NOT_FOUND_STATUS = 'Exam not found'
  INVALID_ANSWERS_STATUS = 'Invalid answers'
  VALID_STATUS = 'Valid'
  NEEDS_CHECK = [STUDENT_NOT_FOUND_STATUS, EXAM_NOT_FOUND_STATUS, INVALID_ANSWERS_STATUS]

  attr_accessible :card, :card_processing_id
  delegate :card_type, :is_bolsao, :exam_date, :campus, to: :card_processing

  belongs_to :exam_execution
  belongs_to :student
  belongs_to :card_processing
  has_many :exam_answers, dependent: :destroy
  accepts_nested_attributes_for :exam_answers

  validates :card, :card_processing_id, presence: true

  mount_uploader :card, StudentExamCardUploader
  after_save :destroy_conflicts!
  before_create :set_status_to_being_processed

  def self.needing_check
    where(status: NEEDS_CHECK)
  end

  def needs_check?
    NEEDS_CHECK.include? status
  end

  def possible_students
    if is_bolsao
      return campus.product_years.map(&:applicant_students).flatten.uniq 
    else
      return campus.klazzes.map(&:enrolled_students).flatten.uniq 
    end
  end

  def possible_exams
    student.possible_exams(is_bolsao, exam_date)
  end

  def answers_needing_check
    exam_answers.select{ |ea| ea.need_to_be_checked? }
  end

  def student_not_found?
    status == STUDENT_NOT_FOUND_STATUS
  end

  def exam_not_found?
    status == EXAM_NOT_FOUND_STATUS
  end

  def invalid_answers?
    status == INVALID_ANSWERS_STATUS
  end

  def scan
    begin
      self.student_number, self.string_of_answers = 
        card_type.scan(card.path, card.normalized_path) 
      set_student
      save!
    rescue => e
      logger.warn e.message
      update_attribute :status, ERROR_STATUS
    end
  end

  def set_student
    if is_bolsao
      student = Applicant.where(number: student_number).first.try(:student)
    else
      student = Student.where(ra: student_number.to_i).first
    end

    if student and possible_students(campus, is_bolsao).include?(student) 
      self.student_id = student.id 
      set_exam
    else
      self.status = STUDENT_NOT_FOUND_STATUS
    end
  end

  def set_exam
    exams = possible_exams
    if exams.present? and exams.size == 1
      self.exam_id = exams.first.id
      set_exam_answers
    else
      self.status = EXAM_NOT_FOUND_STATUS
    end
  end 

  def set_exam_answers
    exam_questions = exam.exam_questions.order(:number)
    (0..(exam_questions.size - 1)).each do |i|      
      exam_answers.build(
        answer: string_of_answers[i], 
        exam_question_id: exam_questions[i].id)
    end

    if answers_needing_check.any?
      self.status = INVALID_ANSWERS_STATUS
    else
      self.status = VALID_STATUS
    end
  end

private

  def set_status_to_being_processed
    self.status = BEING_PROCESSED_STATUS
    true
  end

  def destroy_conflicts!
    if student.present? and exam.present?
      StudentExam.where(student_id: student.id, exam_id: exam.id).each do |student_exam|
        student_exam.destroy if student_exam.id != self.id
      end
    end
    true
  end
end
