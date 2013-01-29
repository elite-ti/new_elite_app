require 'spec_helper'
require 'sidekiq/testing'

describe 'CardProcessorWorker' do  
  it 'performs task' do
    exam = create :exam
    card_type = create :card_type, student_number_length: 7 
    30.times { create :exam_question, exam_id: exam.id }
    student_exam = create :student_exam, exam_id: exam.id, card_type_id: card_type.id

    worker = CardProcessorWorker.new
    worker.perform(student_exam.id)
    ExamAnswer.count.must.equal 30   
  end
end