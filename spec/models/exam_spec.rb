require 'spec_helper'

describe 'Exam' do
  it 'builds valid an exam' do
    build(:exam).valid?.should be_true
  end

  it 'return correct number of questions' do
    exam = create :exam, options_per_question: 5
    exam.number_of_questions.should == 5
  end
end