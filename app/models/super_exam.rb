class SuperExam < ActiveRecord::Base
	has_paper_trail

	attr_accessible :exams_attributes

	has_many :exam_days
	has_many :exam_components, dependent: :destroy
	has_many :exams, through: :exam_components
	accepts_nested_attributes_for :exams, allow_destroy: true

	def name
		exams.map(&:name).join(' - ')
	end
end
