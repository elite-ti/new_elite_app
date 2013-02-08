require 'spec_helper'

describe 'StudentExam' do
  CARD_PATH = "#{Rails.root}/spec/support/card_b.tif"
  
  it 'initializes a valid student exam' do
    exam = create :exam
    card_type = create :card_type

    student_exam = StudentExam.new(
      exam_id: exam.id, 
      card: File.open(CARD_PATH), 
      card_type_id: card_type.id)

    student_exam.valid?.should be_true 
  end

  it 'updates a student exam answers' do
    exam = create :exam
    card_type = create :card_type
    30.times { create :exam_question, exam_id: exam.id }
    student_exam = create :student_exam, exam_id: exam.id, card_type_id: card_type.id

    student_exam.scan
    ExamAnswer.count.should == 30
  end
end
