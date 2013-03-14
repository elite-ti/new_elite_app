class ExamDay < ActiveRecord::Base
  has_paper_trail

  attr_accessible :exam_cycle_id, :super_klazz_id, :exam_id, :datetime

  belongs_to :exam_cycle
  belongs_to :super_klazz
  belongs_to :super_exam 

  has_many :student_exams, dependent: :destroy

  validates :exam_cycle, :super_klazz, :super_exam, presence: :true 
end 