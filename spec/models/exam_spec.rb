require 'spec_helper'

describe 'Exam' do
  it 'builds valid an exam' do
    build(:exam).must.be :valid?
  end

  it 'return correct number of questions' do
    exam = create :exam
    10.times { create :exam_question, exam_id: exam.id }
    exam.number_of_questions.must.equal 10
  end
end