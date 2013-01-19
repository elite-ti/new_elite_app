require 'spec_helper'

describe 'StudentExams' do
  CARD_PATH = "#{Rails.root}/spec/support/card_b.tif"

  before(:each) { log_admin_in }

  it 'creates a student exam without errors' do
    applicant = create :applicant, number: '0246864'

    exam_cycle = create :exam_cycle, is_bolsao: true
    exam = create :exam, exam_cycle_id: exam_cycle.id
    answer_card_type = create :answer_card_type
    30.times { create :exam_question, exam_id: exam.id }

    visit new_student_exam_path

    attach_file 'Card', CARD_PATH
    select answer_card_type.name, from: 'Answer card type'
    select exam.name, from: 'Exam'
    click_button 'Create'

    page.should have_content 'Student exam was successfully created.'
  end

  it 'creates a student exam without student' do
    exam = create :exam
    answer_card_type = create :answer_card_type
    30.times { create :exam_question, exam_id: exam.id }

    visit new_student_exam_path

    attach_file 'Card', CARD_PATH
    select answer_card_type.name, from: 'Answer card type'
    select exam.name, from: 'Exam'
    click_button 'Create'

    page.should have_content 'Some errors scanning card.'
  end
end