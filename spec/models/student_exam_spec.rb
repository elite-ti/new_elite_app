require 'spec_helper'

describe 'StudentExam' do
  CARD_PATH = "#{Rails.root}/spec/support/card_b.tif"
  
  it 'creates a student exam' do
    exam = create :exam
    answer_card_type = create :answer_card_type
    30.times { create :exam_question, exam_id: exam.id }

    StudentExam.create(
      exam_id: exam.id, card: File.open(CARD_PATH), 
      answer_card_type_id: answer_card_type.id)

    StudentExam.count.must.equal 1
    ExamAnswer.count.must.equal 30
  end
end