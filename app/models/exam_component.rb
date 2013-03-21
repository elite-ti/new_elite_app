class ExamComponent < ActiveRecord::Base
	has_paper_trail

  attr_accessible :exam_id, :super_exam_id, :number

  belongs_to :exam
  belongs_to :super_exam

  validates :exam, :super_exam, :number, presence: true
  validates :exam_id, uniqueness: { scope: :super_exam_id }

  before_validation :set_initial_number, on: :create
  after_save :set_number
  after_destroy :set_number

 private

 	def set_initial_number
 		initial_number = 0
 		if super_exam.exam_components.any? 
 			initial_number = super_exam.exam_components.maximum(:number) + 1
 		else
 			initial_number = 1
 		end
 		self.number ||= initial_number 
 	end

 	def set_number
 		super_exam.exam_components.order('number').each_with_index do |exam_component, index|
 			exam_component.update_column :number, index + 1
 		end
 		true
 	end
end
