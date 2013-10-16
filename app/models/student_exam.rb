class StudentExam < ActiveRecord::Base

  BEING_PROCESSED_STATUS = 'Being processed'
  ERROR_STATUS = 'Error'
  STUDENT_NOT_FOUND_STATUS = 'Student not found'
  EXAM_NOT_FOUND_STATUS = 'Exam not found'
  INVALID_ANSWERS_STATUS = 'Invalid answers'
  VALID_STATUS = 'Valid'
  REPEATED_STUDENT = 'Repeated student'
  NEEDS_CHECK = [STUDENT_NOT_FOUND_STATUS, EXAM_NOT_FOUND_STATUS, INVALID_ANSWERS_STATUS, REPEATED_STUDENT, ERROR_STATUS]

  attr_accessible :card, :card_processing_id, :exam_answers_as_string
  delegate :card_type, :is_bolsao, :exam_date, :campus, to: :card_processing

  belongs_to :exam_execution
  belongs_to :student
  belongs_to :card_processing
  has_many :exam_answers, dependent: :destroy
  has_many :exam_questions, through: :exam_answers
  accepts_nested_attributes_for :exam_answers

  validates :card, :card_processing_id, presence: true

  mount_uploader :card, StudentExamCardUploader
  after_save :mark_conclicts!
  before_create :set_status_to_being_processed

  def total_number_of_questions(subject_name=nil)
    if subject_name.present?
      exam_execution.exam.exam_questions.select{|exam_question| exam_question.question.topics.first.subject.name == subject_name}.size
    else
      exam_execution.exam.number_of_questions
    end
  end

  def number_of_correct_answers(subject_name=nil)
    # exam_execution.exam.get_correct_answers
    if subject_name.present?
      exam_answers.select{|exam_answer| exam_answer.exam_question.question.topics.first.subject.name == subject_name && exam_answer.exam_question.question.correct_options.map(&:letter).include?(exam_answer.answer)}.size
    else
      exam_answers.select{|exam_answer| exam_answer.exam_question.question.correct_options.map(&:letter).include? exam_answer.answer}.size
    end
  end  

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

  def possible_exam_executions
    student.possible_exam_executions(is_bolsao, exam_date)
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

  def repeated_student?
    status == REPEATED_STUDENT
  end

  def error?
    status == ERROR_STATUS
  end

  def error!
    update_attribute :status, ERROR_STATUS
  end

  def repeated_cards
    return_value = []
    if repeated_student? 
      return_value = StudentExam.where("id <> #{id}").where(student_id: student._id , exam_execution_id: exam_execution.id)
    end
    return return_value
  end

  def number_of_marked_options
    if string_of_answers.present?
      index = string_of_answers.rindex(/[^Z]/)  
      if index.present?
        return index + 1
      end
    end
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
      set_exam_execution
    else
      self.status = STUDENT_NOT_FOUND_STATUS
    end
  end

  def set_exam_execution
    if card_processing.exam_execution_id.present?
      if student.enrolled_super_klazzes.include?(ExamExecution.find(card_processing.exam_execution_id).super_klazz)
        self.exam_execution_id = card_processing.exam_execution_id
        set_exam_answers
      else
        self.status = EXAM_NOT_FOUND_STATUS
      end
    else
      exam_executions = possible_exam_executions
      if exam_executions.present? and exam_executions.size == 1
        self.exam_execution_id = exam_executions.first.id
        set_exam_answers

      elsif exam_executions.size > 1
        index = string_of_answers.rindex(/[^Z]/)      
        if index.present?
          index = index + 1
          selected_exam_execution = exam_executions.select do |exam_execution|
            exam_execution.exam.number_of_questions == index
          end

          if selected_exam_execution.present? and selected_exam_execution.size == 1
            self.exam_execution_id = selected_exam_execution.first.id
            set_exam_answers
          else
            self.status = EXAM_NOT_FOUND_STATUS
          end
        else
          self.status = ERROR_STATUS
        end
        
      else
        self.status = EXAM_NOT_FOUND_STATUS
      end
    end
  end 

  def set_exam_answers   
    exam_execution.exam.exam_questions.each do |exam_question|
      exam_answers.build(
        answer: string_of_answers[exam_question.number - 1], 
        exam_question_id: exam_question.id)
    end

    # comment
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
    if student.present? and exam_execution.present?
      conflics = StudentExam.where(
        student_id: student.id, 
        exam_execution_id: exam_execution.id
      )
      if conflics.size > 1
        conflics.each do |student_exam|
          student_exam.update_column :status, REPEATED_STUDENT
        end
      end
    end
    true
  end
end
