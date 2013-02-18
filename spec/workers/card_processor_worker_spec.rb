require 'sidekiq'
require_relative '../../app/workers/card_processor_worker.rb'

class CardProcessing; end

describe 'CardProcessorWorker' do  
  it 'performs task' do
    card_processing = stub(:scan)
    CardProcessing.stub(:find) { card_processing }

    card_processing.should_receive(:scan).once

    worker = CardProcessorWorker.new
    worker.perform('id')
  end
end