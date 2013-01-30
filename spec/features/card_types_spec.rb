require 'spec_helper'

describe 'CardTypes' do
  before(:each) { log_admin_in }

  it 'shows all card types' do
    (1..10).each { |i| create :card_type, name: "CardType#{i}" }

    visit card_types_url

    (1..10).each { |i| page.should have_content "CardType#{i}" }
  end

  it 'creates an card type' do
    card_type = build :card_type

    visit card_types_url
    click_link 'New Card Type'
    fill_in 'Name', with: card_type.name
    fill_in 'Parameters', with: card_type.parameters
    fill_in 'Student coordinates', with: card_type.student_coordinates
    attach_file 'Card', card_type.card.path
    click_button 'Create'

    page.should have_content 'Card type was successfully created.'
    CardType.count.must.equal 1
  end

  it 'updates an card type' do
    create :card_type

    visit card_types_url
    click_link 'Edit'
    fill_in 'Name', with: 'NewCardType'
    click_button 'Update'

    page.should have_content 'Card type was successfully updated.'
    CardType.count.must.equal 1
  end
end