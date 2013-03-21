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

	def number_of_questions
		exams.map(&:number_of_questions).reduce(0, &:+)
	end

	def ordered_exams
		exam_components.includes(:exam).order('number').map(&:exam)
	end

	def array_of_answers
		ordered_exams.map(&:array_of_answers).reduce([], &:+)
	end
end
