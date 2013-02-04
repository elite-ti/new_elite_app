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

  it 'sets correct datetime' do
    exam = build :exam
    exam.formatted_datetime = 'Sat, 02/02/2013 06:24'
    exam.datetime.to_s.should == "2013-02-02 06:24:00 -0200"
  end
end