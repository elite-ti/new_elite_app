require 'spec_helper'

describe 'Klazzes' do
  before(:each) { log_admin_in }

  it 'shows all klazzes' do
    (1..10).each { |i| create :klazz, name: "Klazz#{i}" }

    visit klazzes_url

    (1..10).each { |i| page.should have_content "Klazz#{i}" }
    Klazz.count.must.equal 10
  end

  it 'creates a klazz' do
    create :year, name: 'Year'
    create :campus, name: 'Campus'

    visit klazzes_url
    click_link 'New Klazz'
    fill_in 'Name', with: 'Klazz'
    select 'Year', from: 'Year'
    select 'Campus', from: 'Campus'
    click_button 'Create'

    page.should have_content 'Klazz was successfully created.'
    page.should have_content 'Klazzes'
    Product.count.must.equal 1
  end

  it 'updates a klazz' do
    year = create :year, name: 'Year'
    campus = create :campus, name: 'Campus'
    create :klazz, year_id: year.id, campus_id: campus.id

    visit klazzes_url
    click_link 'Edit'
    fill_in 'Name', with: 'Klazz'
    select 'Year', from: 'Year'
    select 'Campus', from: 'Campus'
    click_button 'Update'

    page.should have_content 'Klazz was successfully updated.'
    page.should have_content 'Klazzes'
    Product.count.must.equal 1
  end
end