require 'spec_helper'

describe 'StudentExams' do
  CARD_PATH = "#{Rails.root}/spec/support/card_b.tif"
  ZIP_FILE_PATH = "#{Rails.root}/spec/support/sample.zip"
  RAR_FILE_PATH = "#{Rails.root}/spec/support/sample.rar"

  before(:each) { log_admin_in }

  it 'creates student exams based on a zip' do
    exam_cycle = create :exam_cycle, is_bolsao: true
    exam = create :exam, exam_cycle_id: exam_cycle.id
    answer_card_type = create :answer_card_type
    5.times { create :exam_question, exam_id: exam.id }

    visit new_student_exam_path
    attach_file 'Card', ZIP_FILE_PATH
    select answer_card_type.name, from: 'Answer card type'
    select exam.name, from: 'Exam'
    click_button 'Create'

    page.should have_content 'Student exams were successfully created.'
    StudentExam.count.must.equal 4
  end

  it 'creates a student exam without errors' do
    exam_cycle = create :exam_cycle, is_bolsao: true
    exam = create :exam, exam_cycle_id: exam_cycle.id
    answer_card_type = create :answer_card_type
    5.times { create :exam_question, exam_id: exam.id }

    visit new_student_exam_path
    attach_file 'Card', CARD_PATH
    select answer_card_type.name, from: 'Answer card type'
    select exam.name, from: 'Exam'
    click_button 'Create'

    page.should have_content 'Student exam was successfully created.'
  end
end