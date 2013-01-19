require 'spec_helper'

describe 'AnswerCardTypes' do
  before(:each) { log_admin_in }

  it 'shows all answer card types' do
    (1..10).each { |i| create :answer_card_type, name: "AnswerCardType#{i}" }

    visit answer_card_types_url

    (1..10).each { |i| page.should have_content "AnswerCardType#{i}" }
  end

  it 'creates an answer card type' do
    visit answer_card_types_url
    click_link 'New Answer Card Type'
    fill_in 'Name', with: 'AnwerCardType'
    fill_in 'Parameters', with: '1 2 3 4 5'
    fill_in 'Student number length', with: '7'
    attach_file 'Card', "#{Rails.root}/spec/support/card_b.tif"
    click_button 'Create'

    page.should have_content 'Answer card type was successfully created.'
    AnswerCardType.count.must.equal 1
  end

  it 'updates an answer card type' do
    create :answer_card_type

    visit answer_card_types_url
    click_link 'Edit'
    fill_in 'Name', with: 'NewAnwerCardType'
    click_button 'Update'

    page.should have_content 'Answer card type was successfully updated.'
    AnswerCardType.count.must.equal 1
  end
end