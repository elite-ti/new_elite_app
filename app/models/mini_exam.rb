class MiniExam < ActiveRecord::Base
  attr_accessible :correct_answers, :exam_id, :options_per_question, :subject_id, :order

  belongs_to :exam
  belongs_to :subject
  has_many :exam_questions
end
