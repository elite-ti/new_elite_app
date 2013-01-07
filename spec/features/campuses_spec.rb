require 'spec_helper'

describe 'Campuses' do
  before(:each) { log_admin_in }

  it 'shows all campuses' do
    (1..10).each { |i| create :campus, name: "Campus#{i}" }

    visit campuses_url

    (1..10).each { |i| page.should have_content "Campus#{i}" }
  end

  it 'creates a campus' do
    visit campuses_url
    click_link 'New Campus'
    fill_in 'Name', with: 'Campus'
    click_button 'Create'

    page.should have_content 'Campus was successfully created.'
    Campus.count.must.equal 1
  end

  it 'updates a campus' do
    create :campus

    visit campuses_url
    click_link 'Edit'
    fill_in 'Name', with: 'Campus'
    click_button 'Update'

    page.should have_content 'Campus was successfully updated.'
    Campus.count.must.equal 1
  end
end