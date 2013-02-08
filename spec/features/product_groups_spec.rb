require 'spec_helper'

describe 'ProductGroups' do
  before(:each) { log_admin_in }

  it 'shows all product groups' do
    (1..10).each { |i| create :product_group, name: "ProductGroup#{i}" }

    visit product_groups_url

    (1..10).each { |i| page.should have_content "ProductGroup#{i}" }
    ProductGroup.count.should == 10
  end

  it 'creates a product group' do
    visit product_groups_url
    click_link 'New Product Group'
    fill_in 'Name', with: 'ProductGroup'
    click_button 'Create'

    page.should have_content 'Product group was successfully created.'
    ProductGroup.count.should == 1
  end

  it 'updates a product Group' do
    create :product_group

    visit product_groups_url
    click_link 'Edit'
    fill_in 'Name', with: 'ProductGroup'
    click_button 'Update'

    page.should have_content 'Product group was successfully updated.'
    ProductGroup.count.should == 1
  end
end