require 'spec_helper'

describe 'ProductTypes' do
  before(:each) { log_admin_in }

  it 'shows all product types' do
    (1..10).each { |i| create :product_type, name: "ProductType#{i}" }

    visit product_types_url

    (1..10).each { |i| page.should have_content "ProductType#{i}" }
    ProductType.count.should == 10
  end

  it 'creates a product type' do
    visit product_types_url
    click_link 'New Product Type'
    fill_in 'Name', with: 'ProductType'
    click_button 'Create'

    page.should have_content 'Product type was successfully created.'
    ProductType.count.should == 1
  end

  it 'updates a product type' do
    create :product_type

    visit product_types_url
    click_link 'Edit'
    fill_in 'Name', with: 'ProductType'
    click_button 'Update'

    page.should have_content 'Product type was successfully updated.'
    ProductType.count.should == 1
  end
end