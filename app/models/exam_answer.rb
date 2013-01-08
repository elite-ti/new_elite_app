class ExamAnswer < ActiveRecord::Base
  attr_accessible :answer, :exam_question_id, :student_id

  belongs_to :exam_question
  belongs_to :student

  validates :answer, :exam_question_id, :student_id, presence: true
  validates :exam_question_id, uniqueness: { scope: :student_id }
end
