class StudentExam < ActiveRecord::Base
  has_paper_trail

  BEING_PROCESSED_STATUS = 'Being processed'
  ERROR_STATUS = 'Error'
  VALID_STATUS = 'Valid'
  INVALID_STATUS = 'Invalid'
  CHECKED_STATUS = 'Checked'
  
  attr_accessible :card, :exam_id, :card_type_id, :student_id, 
    :process_result, :exam_answers_attributes, :status, :checked
  attr_reader :checked

  belongs_to :exam
  belongs_to :student
  belongs_to :card_type
  has_many :exam_answers, dependent: :destroy
  accepts_nested_attributes_for :exam_answers

  validates :card, :exam_id, :card_type_id, presence: true
  validates :student_id, uniqueness: { scope: :exam_id }, allow_nil: true

  mount_uploader :card, StudentExamCardUploader

  def self.needing_check
    where(status: 'Invalid')
  end

  def needs_check?
    status == INVALID_STATUS
  end

  def checked=(_checked)
    set_status if _checked
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

  def process_result=(process_result)
    if card_type.is_valid_result?(process_result)
      set_student(process_result[0, card_type.student_number_length])
      set_exam_answers(process_result[card_type.student_number_length, 
        process_result.length - card_type.student_number_length])
      set_status
    else
      self.status = ERROR_STATUS
    end
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

  def set_status
    if student_id.nil? || exam_answers.select{ |ea| ea.invalid? }.any?
      self.status = INVALID_STATUS
    else
      self.status = VALID_STATUS
    end
  end
end
