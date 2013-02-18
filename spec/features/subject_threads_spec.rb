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
    create :product_year, name: 'ProductYear' 

    visit subject_threads_url
    click_link 'New'
    fill_in 'Name', with: 'SubjectThread'
    select 'Subject', from: 'Subject'
    select 'ProductYear', from: 'Product year'
    click_button 'Create'

    page.should have_content 'Subject thread was successfully created.'
    SubjectThread.count.should == 1
  end

  it 'updates a subject thread' do
    create :subject_thread

    visit subject_threads_url
    click_link 'Edit'
    fill_in 'Name', with: 'NewSubjectThread'
    click_button 'Update'

    page.should have_content 'Subject thread was successfully updated.'
    SubjectThread.count.should == 1
  end
end
