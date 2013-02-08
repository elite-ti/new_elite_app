require 'spec_helper'

describe 'CardType' do
  it 'builds valid card type' do
    build(:card_type).valid?.should be_true
  end
end