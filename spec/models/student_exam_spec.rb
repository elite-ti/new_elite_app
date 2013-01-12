require 'spec_helper'

describe 'StudentExam' do
  CARD_PATH = "#{Rails.root}/spec/models/card.tif"

  it 'should creates a new student exam' do
    exam = create :exam
    40.times do 
      question = create :question
      ExamQuestion.create(exam_id: exam.id, question_id: question.id)
    end

    student_exam = StudentExam.new(exam_id: exam.id, card: File.open(CARD_PATH))
    student_exam.scan_card(CARD_PATH)
    student_exam.save

    StudentExam.count.must.equal 1
    ExamAnswer.count.must.equal 40
  end
end