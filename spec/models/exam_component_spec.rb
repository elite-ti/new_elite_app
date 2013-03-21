require 'spec_helper'

describe ExamComponent do 
	it 'sets correct number' do
		super_exam = create :super_exam

		exam = create :exam
		exam_component = ExamComponent.create!(
			super_exam_id: super_exam.id, 
			exam_id: exam.id)
		exam_component.number.should == 1
		
		exam = create :exam
		exam_component = ExamComponent.create!(
			super_exam_id: super_exam.id, 
			exam_id: exam.id)
		exam_component.number.should == 2

		exam = create :exam
		exam_component = ExamComponent.create!(
			super_exam_id: super_exam.id, 
			exam_id: exam.id)
		exam_component.number.should == 3
	end
end