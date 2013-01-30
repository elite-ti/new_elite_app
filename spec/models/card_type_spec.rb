require 'spec_helper'

describe 'CardType' do
  it 'builds valid card type' do
    build(:card_type).must.be :valid?
  end

  it 'evaluates process result as valid' do
    card_type = build(:card_type)
    card_type.is_valid_result?('1234567' + 'ABCDE'*20).must.equal true
  end
end