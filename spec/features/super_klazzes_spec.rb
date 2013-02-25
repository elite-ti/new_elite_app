require 'spec_helper'

describe 'SuperKlazzes' do
  before(:each) { log_admin_in }

  it 'shows all klazzes' do
    super_klazzes = (1..5).map{ |i| create :super_klazz }
    visit super_klazzes_url
    super_klazzes.each{ |sk| page.should have_content sk.name }
  end

  it 'creates a klazz' do
    product_year = create :product_year
    campus = create :campus

    visit super_klazzes_url
    click_link 'New Super Klazz'
    select product_year.name, from: 'Product year'
    select campus.name, from: 'Campus'
    click_button 'Create'

    page.should have_content 'Super klazz was successfully created.'
  end

  it 'updates a klazz' do
    create :klazz
    product_year = create :product_year

    visit super_klazzes_url
    click_link 'Edit'
    select product_year.name, from: 'Product year'
    click_button 'Update'

    page.should have_content 'Super klazz was successfully updated.'
  end
end