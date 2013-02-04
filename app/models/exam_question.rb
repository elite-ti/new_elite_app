class ExamQuestion < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :exam_id, :question_id

  belongs_to :exam
  belongs_to :question

  validates :exam, :question, presence: true
  validates :question_id, uniqueness: { scope: :exam_id }

  after_save :set_number
  after_destroy :set_number

private

  def set_number
    exam.exam_questions.order('number').each_with_index do |exam_question, i|
      exam_question.update_column :number, i+1
    end
  end
end
