class PollQuestion < ActiveRecord::Base
  attr_accessible :number, :poll_pdf_id, :poll_question_category_id, :poll_question_type_id, :teacher_id

  belongs_to :poll_pdf
  belongs_to :poll_question_type
  belongs_to :poll_question_category
  belongs_to :teacher

  has_many :poll_answers, dependent: :destroy

  validates :number, :poll_pdf_id, :poll_question_category_id, :poll_question_type_id, presence: true
end
