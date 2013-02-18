require 'spec_helper'

describe 'ProductYears' do
  before(:each) { log_admin_in }

  it 'shows all Years' do
    5.times { |i| create :product_year, name: "ProductYear#{i}" }

    visit product_years_url

    5.times { |i| page.should have_content "ProductYear#{i}" }
    ProductYear.count.should == 5
  end

  it 'creates a product year' do
    create :product, name: 'Product'
    create :year, number: 2013

    visit product_years_url
    click_link 'New Product Year'
    fill_in 'Name', with: 'Product Year'
    select 'Product', from: 'Product'
    select '2013', from: 'Year'
    click_button 'Create'

    page.should have_content 'Product year was successfully created.'
    ProductYear.count.should == 1
  end

  it 'updates a product year' do
    product = create :product, name: 'Product'
    create :product_year, product_id: product.id

    visit product_years_url
    click_link 'Edit'
    fill_in 'Name', with: 'Year'
    click_button 'Update'

    page.should have_content 'Product year was successfully updated.'
    ProductYear.count.should == 1
  end
end