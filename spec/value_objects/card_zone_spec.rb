require_relative '../../app/value_objects/card_zone.rb'

describe CardZone do
  valid_parameters = %w[1 0 7 0123456789 79 38 271 540 964 453]
  valid_results = ['1234567', '1111111', 'ZW1234Z']
  invalid_results = ['12', '1', 'A123456']

  context 'when valid' do 
    let(:card_zone) { CardZone.new(valid_parameters) }

    it 'checks valid result' do
      valid_results.each do |valid_answer|
        card_zone.is_valid_result?(valid_answer).should be_true 
      end
    end

    it 'checks invalid result' do 
      invalid_results.each do |valid_answer|
        card_zone.is_valid_result?(valid_answer).should be_false
      end
    end
  end

  context 'when invalid' do
    it 'raises exception for invalid parameters' do
      expect { CardZone.new('anything') }.to raise_error
    end
  end
end