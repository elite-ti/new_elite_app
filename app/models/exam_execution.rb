class ExamExecution < ActiveRecord::Base
  has_paper_trail

  attr_accessible :exam_cycle_id, :super_klazz_id, :exam_id, :datetime

  belongs_to :exam_cycle
  belongs_to :super_klazz
  belongs_to :exam
  has_many :student_exams

  validates :exam_cycle, :super_klazz, :exam, presence: :true 

  def name
    exam_cycle.name + ' - ' + super_klazz.name + ' - ' + exam.exam_questions.size.to_s + ' questions'
  end
end 