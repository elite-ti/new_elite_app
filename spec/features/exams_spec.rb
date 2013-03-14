require 'spec_helper'

describe 'Exams' do
  before(:each) { log_admin_in }

  it 'shows all exams' do
    5.times { |i| create :exam }
    visit exams_url
    5.times { |i| page.should have_content "questions" }
    Exam.count.should == 5 
  end

  it 'creates a exam' do
    create :subject, name: 'Subject'

    visit exams_url
    click_link 'New'
    fill_in 'Options per question', with: '5'
    fill_in 'Correct answers', with: 'ABCDE'
    select 'Subject', from: 'Subject'
    click_button 'Create'

    page.should have_content 'Exam was successfully created.'
    Exam.count.should == 1
  end

  it 'updates a exam' do
    create :exam
    subject = create :subject

    visit exams_url
    click_link 'Edit'
    select subject.name, from: 'Subject'
    click_button 'Update'

    page.should have_content 'Exam was successfully updated.'
    Exam.count.should == 1
  end
end