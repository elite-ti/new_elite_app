require 'spec_helper'

describe 'Klazzes' do
  before(:each) { log_admin_in }

  it 'shows all klazzes' do
    5.times { |i| create :klazz, name: "Klazz#{i}" }
    visit klazzes_url
    5.times { |i| page.should have_content "Klazz#{i}" }
  end

  it 'creates a klazz' do
    super_klazz = create :super_klazz

    visit klazzes_url
    click_link 'New Klazz'
    fill_in 'Name', with: 'Klazz'
    select super_klazz.name, from: 'Super klazz'
    click_button 'Create'

    page.should have_content 'Klazz was successfully created.'
  end

  it 'updates a klazz' do
    create :klazz

    visit klazzes_url
    click_link 'Edit'
    fill_in 'Name', with: 'Klazz'
    click_button 'Update'

    page.should have_content 'Klazz was successfully updated.'
  end
end