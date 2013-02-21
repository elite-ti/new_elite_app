require 'spec_helper'

describe ExamQuestion do
  it 'builds valid an exam question' do
    build(:exam_question).valid?.should be_true
  end

  it 'sets correct number in new question' do
    exam = create :exam, options_per_question: 5
    ExamQuestion.all.map(&:number).should == (1..5).to_a 
    ExamQuestion.first.destroy
    ExamQuestion.all.map(&:number).sort.should == (1..4).to_a
  end
end