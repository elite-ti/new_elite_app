require_relative '../../app/value_objects/card_zone.rb'
require_relative '../../app/value_objects/card_configuration.rb'

describe CardConfiguration do
  valid_parameters = '0.4 60 540 80 40 1284 4847 1 0 7 0123456789 79 38 271 540 964 453 2 600 50 ABCDE 77 38 170 1054 473 3454'

  context 'when valid' do 
    let(:card_configuration) { CardConfiguration.new(valid_parameters) }

    it 'parses valid result' do
      student_number = '1234567'
      answer = 'ABCDE' * 20
      card_configuration.parse_result(student_number+answer).should == [student_number, answer]
    end

    it 'raise exception for invalid result' do 
      expect do 
        card_configuration.parse_result('wrong') 
      end.to raise_error CardConfiguration::InvalidResult
    end
  end

  context 'when invalid' do
    it 'raises exception for invalid parameters' do
      expect do 
        CardConfiguration.new('anything') 
      end.to raise_error CardConfiguration::InvalidParameters
    end
  end
end