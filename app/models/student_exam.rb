class StudentExam < ActiveRecord::Base
  attr_accessible :card, :exam_id, :answer_card_type_id
  attr_accessor :answers

  belongs_to :exam
  belongs_to :student

  has_many :exam_answers, dependent: :destroy

  validates :card, :exam_id, :student_id, presence: true
  validates :exam_id, uniqueness: { scope: :student_id }

  mount_uploader :card, AnswerCardUploader

  before_save :build_exam_answers

  def scan_card(temp_card_url)
    self.student_id = Student.first.try(:id) || Student.create(name: 'Student', ra: '1').id
    self.answers = RunProgram.card_scanner(temp_card_url)
  end

private

  def build_exam_answers
    exam_questions = exam.exam_questions.order(:number)
    for i in 0..(answers.size-1)
      exam_answers.build(answer: answers[i], exam_question_id: exam_questions[i].id)
    end
  end
end
