class StudentExam < ActiveRecord::Base

  BEING_PROCESSED_STATUS = 'Being processed'
  ERROR_STATUS = 'Error'
  STUDENT_NOT_FOUND_STATUS = 'Student not found'
  EXAM_NOT_FOUND_STATUS = 'Exam not found'
  INVALID_ANSWERS_STATUS = 'Invalid answers'
  VALID_STATUS = 'Valid'
  REPEATED_STUDENT = 'Repeated student'
  NEEDS_CHECK = [STUDENT_NOT_FOUND_STATUS, EXAM_NOT_FOUND_STATUS, INVALID_ANSWERS_STATUS, REPEATED_STUDENT, ERROR_STATUS]

  attr_accessible :card, :card_processing_id, :exam_answer_as_string
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
    if exam_answer_as_string.nil?
      if subject_name.present?
        exam_answers.select{|exam_answer| exam_answer.exam_question.question.topics.first.subject.name == subject_name && (exam_answer.exam_question.question.correct_options.size == 5 || exam_answer.exam_question.question.correct_options.map(&:letter).include?(exam_answer.answer))}.size
      else
        exam_answers.select{|exam_answer| exam_answer.exam_question.question.correct_options.size == 5 || exam_answer.exam_question.question.correct_options.map(&:letter).include?(exam_answer.answer)}.size
      end
    else
      if subject_name.present?
        grade = 0
        exam_questions = self.exam_execution.try(:exam).try(:exam_questions).sort_by { |exam_question| exam_question.number }
        exam_answer_as_string.split('').each_with_index{|answer, index| grade = grade + 1 if exam_questions[index].question.topics.first.subject.name == subject_name && (exam_questions[index].question.correct_options.size == 5 || exam_questions[index].question.correct_options.map(&:letter).include?(answer))}
        grade
        # exam_answers.select{|exam_answer| exam_answer.exam_question.question.topics.first.subject.name == subject_name && (exam_answer.exam_question.question.correct_options.size == 5 || exam_answer.exam_question.question.correct_options.map(&:letter).include?(exam_answer.answer))}.size
      else
        grade = 0
        exam_questions = self.exam_execution.try(:exam).try(:exam_questions).sort_by { |exam_question| exam_question.number }
        exam_answer_as_string.split('').each_with_index{|answer, index| grade = grade + 1 if exam_questions[index].question.correct_options.size == 5 || exam_questions[index].question.correct_options.map(&:letter).include?(answer)}
        grade
      end
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
      return Applicant.where(exam_campus_id: campus.id, exam_datetime: (exam_date.beginning_of_day..exam_date.end_of_day)).includes(:student => :applicants).map(&:student)
    else
      return campus.enrolled_students.uniq
    end
  end

  def possible_exam_executions
    student.possible_exam_executions(is_bolsao, exam_date)
  end

  def answers_needing_check
    create_exam_answers unless exam_answers.present?
    exam_answers.select{ |ea| ea.need_to_be_checked? }
    # Hash[(1...exam_answer_as_string.size).zip exam_answer_as_string.split('')].select{|key, value| ['Z', 'W'].include? value }
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
      if student.enrolled_super_klazzes.include?(ExamExecution.find(card_processing.exam_execution_id).super_klazz) || is_bolsao
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
    number_of_questions = exam_execution.exam.exam_questions.size
    self.exam_answer_as_string = string_of_answers[0..number_of_questions-1]
    check_answers
  end

  def check_answers
    if false && answers_needing_check.any? && !is_bolsao
      self.status = INVALID_ANSWERS_STATUS
    else
      self.status = VALID_STATUS
    end    
  end

  def set_grades
    grades_total = Hash[*exam_execution.exam.exam_questions.map(&:question).map(&:topics).map(&:first).map(&:subject).map(&:code).group_by{|sub| sub}.map{|key, value| [key,value.size]}.flatten]
    grades_hash = Hash[*grades_total.map{|k,v| [k,0]}.flatten]
    exam_answers.each do |exam_answer|
      subject = exam_answer.exam_question.question.topics.first.subject.code
      correct_answers = exam_answer.exam_question.question.options.select{|o| o.correct}.map(&:letter)
      grades_hash[subject] = grades_hash[subject] + 1 if correct_answers.include?(exam_answer.answer) || correct_answers.size == 5
    end
    p grades_hash
    self.grades = grades_hash.map{|subject_name,grade|[subject_name,(10*grade.to_f/grades_total[subject_name].to_f).round(2)].join(',')}.join(',')
  end

  def create_exam_answers
    exam_answers.destroy_all
    exam_execution.exam.exam_questions.each do |exam_question|
      exam_answer = exam_answers.build(
        answer: string_of_answers[exam_question.number - 1] || 'Z', 
        exam_question_id: exam_question.id)
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
    if student.present? and exam_execution.present? and !is_bolsao
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
