require 'spec_helper'

describe Option do
  it 'builds valid option' do
    question = create :question

    option = Option.new(question_id: question.id, correct: true)
    option.valid?.should == true

    option = Option.new(question_id: question.id, correct: false)
    option.valid?.should == true

    option = Option.new(question_id: question.id)
    option.valid?.should == true
  end

  it 'sets letter correctly' do 
    question = create :question
    5.times { Option.create(question_id: question.id) }
    Option.all.map(&:letter).sort.join('').should == 'ABCDE'
  end
end