class StudentExam < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :card, :exam_id, :answer_card_type_id

  belongs_to :exam
  belongs_to :student

  has_many :exam_answers, dependent: :destroy
  belongs_to :answer_card_type

  validates :card, :exam_id, :answer_card_type_id, presence: true
  validates :exam_id, uniqueness: { scope: :student_id }

  mount_uploader :card, StudentExamCardUploader

  before_create :scan_card

  def needs_check?
    no_student? or any_answer_needs_check?
  end

  def no_student?
    student_id.nil?
  end

  def any_answer_needs_check?
    exam_answers.select { |exam_answer| exam_answer.needs_check? }.empty?
  end

private

  def scan_card
    all_answers = CardProcessor.scan(card.file.path)
    if all_answers.blank?
      errors.add(:card, 'Error scanning card.')
      return false;
    end

    set_student(all_answers.slice(0, answer_card_type.student_number_length))
    set_exam_answers(all_answers.slice(answer_card_type.student_number_length, exam.number_of_questions))
    true
  end

  def set_student(student_number)
    if(exam.exam_cycle.is_bolsao?)
      self.student_id = Applicant.where(number: student_number).first.try(:student).try(:id)
    else
      self.student_id = Student.where(ra: student_number).first.try(:id)
    end
  end

  def set_exam_answers(answers)
    exam_questions = exam.exam_questions.order(:number)
    for i in 0..(answers.size-1)
      exam_answers.build(answer: answers[i], exam_question_id: exam_questions[i].id)
    end
  end
end
