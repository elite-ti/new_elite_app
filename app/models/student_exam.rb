class StudentExam < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :card, :exam_id, :answer_card_type_id, :student_id
  attr_accessor :exam_answer_values

  belongs_to :exam
  belongs_to :student

  has_many :exam_answers, dependent: :destroy
  belongs_to :answer_card_type

  validates :card, :exam_id, :answer_card_type_id, presence: true
  validates :student_id, uniqueness: { scope: :exam_id }, allow_nil: true

  mount_uploader :card, StudentExamCardUploader
  after_create :set_answers

  def answers_needing_check
    exam_answers.select { |exam_answer| exam_answer.needs_check? }
  end

  def needs_check?
    no_student? or any_answer_needs_check?
  end

  def no_student?
    student_id.nil?
  end

  def any_answer_needs_check?
    not answers_needing_check.empty?
  end

  def set_answers
    b_type = File.join(Rails.root, 'vendor/programs/card_processor/b_type')
    png_path = card.png.current_path
    all_answers = `#{b_type} #{png_path} #{png_path}`

    if all_answers.blank?
      errors.add(:card, 'Error scanning card.')
      return false
    end

    set_student(all_answers.slice(0, answer_card_type.student_number_length))
    set_exam_answers(all_answers.slice(answer_card_type.student_number_length, exam.number_of_questions))
  end

  def student_name_png_url
    path = File.join(File.dirname(card.current_path), 'student_name.png')
    create_student_name_png unless File.exist?(path)
    path.split(File.join(Rails.root, 'public'))[1]
  end

  def possible_students
    year = exam.exam_cycle.year
    if(exam.exam_cycle.is_bolsao?)
      year.applicant_students
    else
      year.enrolled_students
    end
  end

private

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
      exam_answers.create!(answer: answers[i], exam_question_id: exam_questions[i].id)
    end
  end

  def create_student_name_png
    image = MiniMagick::Image.open(card.png.current_path)
    image.crop '845x280+398+35'
    image.resize '50%'
    image.write File.join(File.dirname(card.png.current_path), 'student_name.png')
  end
end
