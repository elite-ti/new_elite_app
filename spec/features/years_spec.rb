require 'spec_helper'

describe 'Years' do
  before(:each) { log_admin_in }

  it 'shows all years' do
    5.times { |i| create :year, number: 2013+i }
    visit years_url
    5.times { |i| page.should have_content "#{2013+i}" }
    Year.count.should == 5 
  end

  it 'creates a years' do
    visit years_url
    click_link 'New Year'
    fill_in 'Number', with: '2013'
    fill_in 'year_start_date', with: '2013-1-1'
    fill_in 'year_end_date', with: '2013-12-31'
    click_button 'Create'

    page.should have_content 'Year was successfully created.'
    Year.count.should == 1
  end

  it 'updates a years' do
    create :year

    visit years_url
    click_link 'Edit'
    fill_in 'Number', with: '2014'
    click_button 'Update'

    page.should have_content 'Year was successfully updated.'
    Year.count.should == 1
  end
end