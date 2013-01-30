require 'mustard'
require_relative '../../app/value_objects/card_zone.rb'
require_relative '../../app/value_objects/card_configuration.rb'

describe 'CardConfiguration' do
  valid_parameters = '0.4 1 0 7 0123456789 79 38 271 540 964 453 2 600 50 ABCDE 77 38 170 1054 473 3454'
  valid_results = ['0'*7 + 'Z'*100, 'Z'*107, 'W'*107, '1'*7 + 'ABCDE'*20] 
  invalid_results = ['01234', '1234567ZZ', '1234567' + 'Z'*99 + 'X'] 

  context 'valid' do 
    let(:card_configuration) { CardConfiguration.new(valid_parameters) }

    it 'checks valid results' do
      valid_results.each do |valid_result|
        card_configuration.is_valid_result?(valid_result).must.equal true
      end
    end

    it 'checks invalid results' do 
      invalid_results.each do |valid_result|
        card_configuration.is_valid_result?(valid_result).must.equal false
      end
    end
  end

  context 'invalid' do
    it 'raises exception for invalid parameters' do
      expect { CardConfiguration.new('anything') }.to raise_error
    end
  end
end