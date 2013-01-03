class PollQuestion < ActiveRecord::Base
  attr_accessible :number, :pdf_id, :question_category_id, :question_type_id, :teacher_id

  belongs_to :pdf
  belongs_to :question_type
  belongs_to :question_category
  belongs_to :teacher

  has_many :answers, dependent: :destroy

  validates :number, :pdf_id, :question_category_id, :question_type_id, presence: true
end
