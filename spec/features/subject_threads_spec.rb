require 'spec_helper'

describe 'SubjectThreads' do
  before(:each) { log_admin_in }

  it 'shows all subject threads' do
    5.times { |i| create :subject_thread, name: "SubjectThread#{i}" }
    visit subject_threads_url
    5.times { |i| page.should have_content "SubjectThread#{i}" }
    SubjectThread.count.should == 5
  end

  it 'creates a subject thread' do
    create :subject, name: 'Subject'
    create :year, name: 'Year'

    visit subject_threads_url
    click_link 'New'
    fill_in 'Name', with: 'SubjectThread'
    select 'Subject', from: 'Subject'
    select 'Year', from: 'Year'
    click_button 'Create'

    page.should have_content 'Subject thread was successfully created.'
    SubjectThread.count.should == 1
  end

  it 'updates a subject thread' do
    subject = create :subject, name: 'Subject'
    year = create :year, name: 'Year'
    create :subject_thread, subject_id: subject.id, year_id: year.id

    visit subject_threads_url
    click_link 'Edit'
    fill_in 'Name', with: 'NewSubjectThread'
    select 'Subject', from: 'Subject'
    select 'Year', from: 'Year'
    click_button 'Update'

    page.should have_content 'Subject thread was successfully updated.'
    SubjectThread.count.should == 1
  end
end
