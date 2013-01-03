class PollPdf < ActiveRecord::Base
  attr_accessible :klazz_id, :poll_id

  belongs_to :poll
  belongs_to :klazz
  has_many :questions, dependent: :destroy
  has_many :answers, through: :questions

  validates :klazz_id, :poll_id, presence: true

  def create_question(question_type_name, question_category_name, teacher = nil)
    number = questions.count + 1
    questions.create(
      number: number,
      question_type_id: QuestionType.find_by_name!(question_type_name).id,
      question_category_id: QuestionCategory.find_by_name!(question_category_name).id,
      teacher_id: teacher.try(:id)
    )
  end
end
