require 'spec_helper'

describe 'Topics' do
  before(:each) { log_admin_in }

  it 'shows all topics' do
    5.times { |i| create :topic, name: "Topic#{i}" }
    visit topics_url
    5.times { |i| page.should have_content "Topic#{i}" }
    Topic.count.should == 5 
  end

  it 'creates a topic' do
    subject = create :subject

    visit topics_url
    click_link 'New Topic'
    fill_in 'Name', with: 'Topic'
    fill_in 'Itens', with: 'Itens...'
    select subject.name, from: 'Subject'
    click_button 'Create'

    page.should have_content 'Topic was successfully created.'
    Topic.count.should == 1
  end

  it 'updates a topic' do
    create :topic

    visit topics_url
    click_link 'Edit'
    fill_in 'Name', with: 'Updated Topic'
    click_button 'Update'

    page.should have_content 'Topic was successfully updated.'
    Topic.count.should == 1
  end
end
