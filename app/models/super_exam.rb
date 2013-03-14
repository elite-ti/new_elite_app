class SuperExam < ActiveRecord::Base
	has_paper_trail

	has_many :exam_days
	has_many :exam_components, dependent: :destroy
	has_many :exams, through: :exam_components
end

