class ExamAnswer < ActiveRecord::Base
  attr_accessible :answer, :exam_question_id, :student_exam_id

  belongs_to :exam_question
  belongs_to :student_exam

  validates :answer, :exam_question_id, :student_exam_id, presence: true
  validates :exam_question_id, uniqueness: { scope: :student_exam_id }
end
