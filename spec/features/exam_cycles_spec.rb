require 'spec_helper'

describe 'ExamCycles' do
  before(:each) { log_admin_in }

  it 'shows all exam cycles' do
    5.times { |i| create :exam_cycle, name: "ExamCycle#{i}" }
    visit exam_cycles_url
    5.times { |i| page.should have_content "ExamCycle#{i}" }
  end

  it 'creates a exam cycle' do
    create :product_year, name: 'ProductYear'

    visit exam_cycles_url
    click_link 'New Exam Cycle'
    fill_in 'Name', with: 'ExamCycle'
    select 'ProductYear', from: 'Product year'
    click_button 'Create'

    page.should have_content 'Exam cycle was successfully created.'
    ExamCycle.count.should == 1
  end

  it 'updates a exam cycle' do
    create :exam_cycle

    visit exam_cycles_url
    click_link 'Edit'
    fill_in 'Name', with: 'NewExamCycle'
    click_button 'Update'

    page.should have_content 'Exam cycle was successfully updated.'
    ExamCycle.count.should == 1
  end
end