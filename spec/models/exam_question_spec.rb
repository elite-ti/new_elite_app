require 'spec_helper'

describe 'ExamQuestion' do
  it 'builds valid an exam question' do
    build(:exam_question).must.be :valid?
  end

  it 'sets correct number in new question' do
    exam_question = create :exam_question
    exam_question.number.must.equal 1
  end
end