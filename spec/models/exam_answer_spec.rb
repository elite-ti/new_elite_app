require 'spec_helper'

describe 'ExamAnswer' do
  it 'builds valid object' do
    exam_question = create :exam_question
    student_exam = create :student_exam
    exam_answer = ExamAnswer.new(
      answer: 'A',
      exam_question_id: exam_question.id,
      student_exam_id: student_exam.id
    ).valid?.should be_true
  end
end