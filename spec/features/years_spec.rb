require 'spec_helper'

describe 'Years' do
  before(:each) { log_admin_in }

  it 'shows all Years' do
    (1..10).each { |i| create :year, name: "Year#{i}" }

    visit years_url

    (1..10).each { |i| page.should have_content "Year#{i}" }
    Year.count.should == 10
  end

  it 'creates a Year' do
    create :product, name: 'Product'

    visit years_url
    click_link 'New Year'
    fill_in 'Name', with: 'Year'
    select 'Product', from: 'Product'
    fill_in 'Year number', with: '2013'
    click_button 'Create'

    page.should have_content 'Year was successfully created.'
    Year.count.should == 1
  end

  it 'updates a Year' do
    product = create :product, name: 'Product'
    create :year, product_id: product.id

    visit years_url
    click_link 'Edit'
    fill_in 'Name', with: 'Year'
    select 'Product', from: 'Product'
    click_button 'Update'

    page.should have_content 'Year was successfully updated.'
    Year.count.should == 1
  end
end