require 'spec_helper'

describe 'Topic' do
  it 'builds valid topic' do
    build(:topic).valid?.should be_true
  end
end
