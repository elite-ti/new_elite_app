require 'spec_helper'

describe 'Exam' do
  it 'builds valid an exam' do
    build(:exam).valid?.should be_true
  end

  it 'return correct number of questions' do
    exam = create :exam
    10.times { create :exam_question, exam_id: exam.id }
    exam.number_of_questions.should == 10
  end
end