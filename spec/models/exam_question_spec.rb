require 'spec_helper'

describe ExamQuestion do
  it 'builds valid an exam question' do
    build(:exam_question).must.be :valid?
  end

  it 'sets correct number in new question' do
    exam = create :exam
    5.times { create :exam_question, exam_id: exam.id }
    ExamQuestion.all.map(&:number).should == (1..5).to_a 
    ExamQuestion.first.destroy
    ExamQuestion.all.map(&:number).should == (1..4).to_a
  end
end