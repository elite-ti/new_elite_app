class StudentExam < ActiveRecord::Base
  has_paper_trail

  BEING_PROCESSED_STATUS = 'Being processed'
  ERROR_STATUS = 'Error'
  VALID_STATUS = 'Valid'
  INVALID_STATUS = 'Invalid'
  CHECKED_STATUS = 'Checked'
  DOUBLED_STATUS = 'Doubled'
  
  attr_accessible :card, :exam_id, :card_type_id, :student_id

  belongs_to :exam
  belongs_to :student
  belongs_to :card_type
  has_many :exam_answers, dependent: :destroy
  accepts_nested_attributes_for :exam_answers

  validates :card, :exam_id, :card_type_id, presence: true

  before_validation :set_status_to_being_processed, on: :create
  mount_uploader :card, StudentExamCardUploader

  def self.needing_check
    where(status: INVALID_STATUS)
  end

  def needs_check?
    INVALID_STATUS == status
  end

  def possible_students
    year = exam.exam_cycle.year
    if(exam.exam_cycle.is_bolsao?)
      year.applicant_students
    else
      year.enrolled_students
    end
  end

  def answers_needing_check
    exam_answers.select{ |ea| ea.invalid? }
  end

  def set_process_result(process_result)
    if card_type.is_valid_result?(process_result)
      set_student(process_result[0, card_type.student_number_length])
      set_exam_answers(process_result[card_type.student_number_length, 
        process_result.length - card_type.student_number_length])
      save!
      set_status_after_processing
    else
      set_status_to_error
    end
  end

  def set_user_modifications(student_id, exam_answers_attributes)
    self.student_id = student_id
    self.exam_answers_attributes = exam_answers_attributes || []
    save!
    set_status_after_user_modifications
  end

private

  def set_student(student_number)
    if exam.exam_cycle.is_bolsao?
      self.student_id = Applicant.where(number: student_number).first.try(:student).try(:id)
    else
      self.student_id = Student.where(ra: student_number).first.try(:id)
    end
  end

  def set_exam_answers(answers)
    exam_questions = exam.exam_questions.order(:number)
    (0..(exam_questions.size - 1)).each do |i|
      exam_answers.build(answer: answers[i], exam_question_id: exam_questions[i].id)
    end
  end

  def set_status_to_being_processed
    self.status = BEING_PROCESSED_STATUS
  end

  def set_status_to_error
    self.status = ERROR_STATUS
    save!
  end

  def set_status_after_processing
    if student.nil? || exam_answers.select{ |ea| ea.invalid? }.any?
      self.status = INVALID_STATUS
    else
      self.status = VALID_STATUS
    end
    save!
  end

  def set_status_after_user_modifications
    if student.nil?
      self.status = INVALID_STATUS
    else
      if StudentExam.where(student_id: student.id, exam_id: exam.id).count > 1
        self.status = DOUBLED_STATUS
      else
        self.status = VALID_STATUS
      end
    end
    save!
  end
end
