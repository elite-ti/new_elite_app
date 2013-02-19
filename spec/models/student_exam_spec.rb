require 'spec_helper'

describe 'StudentExam' do
  CARD_PATH = "#{Rails.root}/spec/support/card_b.tif"
  
  it 'initializes a valid student exam' do
    card_type = create :card_type
    card_processing = stub(
      card_type: card_type, 
      id: 1, 
      is_bolsao: false)

    student_exam = StudentExam.create!(
      card: File.open(CARD_PATH), 
      card_processing_id: card_processing.id)
    student_exam.valid?.should be_true

    student_exam.stub(card_processing: card_processing)
    student_exam.scan
    student_exam.student_not_found?.should be_true 
  end
end
