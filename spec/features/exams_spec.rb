require 'spec_helper'

describe 'Exams' do
  before(:each) { log_admin_in }

  it 'shows all exams' do
    (1..10).each { |i| create :exam, name: "Exam#{i}" }

    visit exams_url

    (1..10).each { |i| page.should have_content "Exam#{i}" }
    Product.count.must.equal 10
  end

  it 'creates a exam' do
    create :exam_cycle, name: 'ExamCycle'

    visit exams_url
    click_link 'New Exam'
    fill_in 'Name', with: 'Exam'
    select 'ExamCycle', from: 'Exam cycle'
    click_button 'Create'

    page.should have_content 'Exam was successfully created.'
    Exam.count.must.equal 1
  end

  it 'updates a exam' do
    exam_cycle = create :exam_cycle, name: 'ExamCycle'
    create :exam, exam_cycle_id: exam_cycle.id

    visit exams_url
    click_link 'Edit'
    fill_in 'Name', with: 'NewExam'
    select 'ExamCycle', from: 'Exam cycle'
    click_button 'Update'

    page.should have_content 'Exam was successfully updated.'
    Exam.count.must.equal 1
  end
end