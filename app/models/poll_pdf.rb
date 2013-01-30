class PollPdf < ActiveRecord::Base
  attr_accessible :klazz_id, :poll_id

  belongs_to :poll
  belongs_to :klazz
  has_many :poll_questions, dependent: :destroy
  has_many :poll_answers, through: :poll_questions

  validates :klazz_id, :poll_id, presence: true

  def create_poll_question(poll_question_type_name, poll_question_category_name, teacher = nil)
    number = poll_questions.count + 1
    poll_questions.create(
      number: number,
      poll_question_type_id: PollQuestionType.find_by_name!(poll_question_type_name).id,
      poll_question_category_id: PollQuestionCategory.find_by_name!(poll_question_category_name).id,
      teacher_id: teacher.try(:id)
    )
  end
end
