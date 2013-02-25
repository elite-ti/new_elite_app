require 'spec_helper'

describe 'Exams' do
  before(:each) { log_admin_in }

  it 'shows all exams' do
    5.times { |i| create :exam, name: "Exam#{i}" }
    visit exams_url
    5.times { |i| page.should have_content "Exam#{i}" }
    Exam.count.should == 5 
  end

  it 'creates a exam' do
    visit exams_url
    click_link 'New'
    fill_in 'Name', with: 'Exam'
    fill_in 'Options per question', with: '5'
    fill_in 'Correct answers', with: 'ABCDE'
    click_button 'Create'

    page.should have_content 'Exam was successfully created.'
    Exam.count.should == 1
  end

  it 'updates a exam' do
    create :exam

    visit exams_url
    click_link 'Edit'
    fill_in 'Name', with: 'NewExam'
    click_button 'Update'

    page.should have_content 'Exam was successfully updated.'
    Exam.count.should == 1
  end
end