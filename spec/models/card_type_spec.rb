require 'spec_helper'

describe 'CardType' do
  it 'builds valid card type' do
    build(:card_type).must.be :valid?
  end
end