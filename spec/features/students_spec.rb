require 'spec_helper'

describe 'Students' do
  before(:each) { log_admin_in }

  it 'shows all students' do
    (1..10).each { |i| create :student, ra: i.to_s }

    visit students_url

    (1..10).each { |i| page.should have_content "Student#{i}" }
  end

  it 'creates a student' do
    visit students_url
    click_link 'New Student'
    fill_in 'Ra', with: '1'
    fill_in 'Name', with: 'Student'
    fill_in 'Email', with: 'student@example.com'
    click_button 'Create'

    page.should have_content 'Student was successfully created.'
    Student.count.should == 1
  end

  it 'updates a student' do
    create :student, ra: 1

    visit students_url
    click_link 'Edit'
    fill_in 'Ra', with: '111'
    fill_in 'Name', with: 'New Student'
    fill_in 'Email', with: 'new_student@example.com'
    click_button 'Update'

    page.should have_content 'Student was successfully updated.'
    Student.count.should == 1
  end
end