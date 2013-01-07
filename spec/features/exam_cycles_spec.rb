require 'spec_helper'

describe 'ExamCycles' do
  before(:each) { log_admin_in }

  it 'shows all exam cycles' do
    (1..10).each { |i| create :exam_cycle, name: "ExamCycle#{i}" }

    visit exam_cycles_url

    (1..10).each { |i| page.should have_content "ExamCycle#{i}" }
  end

  it 'creates a exam cycle' do
    create :year, name: 'Year'

    visit exam_cycles_url
    click_link 'New Exam Cycle'
    fill_in 'Name', with: 'ExamCycle'
    select 'Year', from: 'Year'
    click_button 'Create'

    page.should have_content 'Exam cycle was successfully created.'
    ExamCycle.count.must.equal 1
  end

  it 'updates a exam cycle' do
    year = create :year, name: 'Year'
    create :exam_cycle, year_id: year.id

    visit exam_cycles_url
    click_link 'Edit'
    fill_in 'Name', with: 'NewExamCycle'
    select 'Year', from: 'Year'
    click_button 'Update'

    page.should have_content 'Exam cycle was successfully updated.'
    ExamCycle.count.must.equal 1
  end
end