require 'spec_helper'

describe 'ExamAnswer' do
  # it 'builds valid an exam answer' do
  #   ea = new_exam_answer
  #   ea.valid?.must.equal true
  # end

  # # it 'sets check attribute correctly' do
  # #   exam_answer = creates_exam_answer

  # #   ExamAnswer::VALID_ANSWERS.each do |answer|
  # #     exam_answer.update_attribute :answer, answer
  # #     exam_answer.checked?.must.equals true
  # #   end

  # #   ExamAnswer::VALID_ANSWERS.each do |answer|
  # #     exam_answer.update_attribute :answer, answer
  # #     exam_answer.checked?.must.equal false
  # #   end
  # # end

  # def new_exam_answer
  #   exam = create :exam
  #   answer_card_type = create :answer_card_type
  #   exam_question = create :exam_question, exam_id: exam.id
  #   student_exam = StudentExam.new(
  #     exam_id: exam.id, card: File.open(B_TYPE_CARD_PATH), 
  #     answer_card_type_id: answer_card_type.id)
  #   ExamAnswer.new(
  #     answer: 'A', exam_question_id: exam_question.id, 
  #     student_exam_id: student_exam.id)
  # end
end