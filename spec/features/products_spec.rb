require 'spec_helper'

describe 'Products' do
  before(:each) { log_admin_in }

  it 'shows all products' do
    (1..10).each { |i| create :product, name: "Product#{i}" }

    visit products_url

    (1..10).each { |i| page.should have_content "Product#{i}" }
    Product.count.must.equal 10
  end

  it 'creates a product' do
    create :product_type, name: 'ProductType'

    visit products_url
    click_link 'New Product'
    fill_in 'Name', with: 'Product'
    select 'ProductType', from: 'Product type'
    click_button 'Create'

    page.should have_content 'Product was successfully created.'
    Product.count.must.equal 1
  end

  it 'updates a product' do
    product_type = create :product_type, name: 'ProductType'
    create :product, product_type_id: product_type.id

    visit products_url
    click_link 'Edit'
    fill_in 'Name', with: 'Product'
    select 'ProductType', from: 'Product type'
    click_button 'Update'

    page.should have_content 'Product was successfully updated.'
    Product.count.must.equal 1
  end
end
