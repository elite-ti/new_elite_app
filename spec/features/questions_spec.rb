require 'spec_helper'

describe 'Questions' do
  before(:each) { log_admin_in }

  it 'shows all questions' do
    (1..10).each { |i| create :question, name: "Question#{i}" }

    visit questions_url

    (1..10).each { |i| page.should have_content "Question#{i}" }
  end

  it 'creates a question' do
    visit questions_url
    click_link 'New Question'
    fill_in 'Name', with: 'Question'
    click_button 'Create'

    page.should have_content 'Question was successfully created.'
    Question.count.must.equal 1
  end

  it 'updates a question' do
    create :question

    visit questions_url
    click_link 'Edit'
    fill_in 'Name', with: 'Question'
    click_button 'Update'

    page.should have_content 'Question was successfully updated.'
    Question.count.must.equal 1
  end
end