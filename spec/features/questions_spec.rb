require 'spec_helper'

describe 'Questions' do
  before(:each) { log_admin_in }

  it 'shows all questions' do
    5.times { |i| create :question, stem: "QuestionStem#{i}" }

    visit questions_url

    5.times { |i| page.should have_content "QuestionStem#{i}" }
  end

  it 'creates a question' do
    visit questions_url
    click_link 'New Question'
    fill_in 'Stem', with: 'QuestionStem'
    fill_in 'Model answer', with: 'ModelAnswer'
    click_button 'Create'

    page.should have_content 'Question was successfully created.'
    Question.count.should == 1
  end

  it 'updates a question' do
    create :question

    visit questions_url
    click_link 'Edit'
    fill_in 'Stem', with: 'QuestionNewStem'
    click_button 'Update'

    page.should have_content 'Question was successfully updated.'
    Question.count.should == 1
  end
end