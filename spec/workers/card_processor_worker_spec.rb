class CardProcessor; end

require 'sidekiq'
require_relative '../../app/workers/card_processor_worker.rb'

describe 'CardProcessorWorker' do  
  it 'performs task' do
    # card_processor = stub(:scan)
    # CardProcessor.stub(:find) { card_processor }

    # card_processor.should_receive(:process).once

    # worker = CardProcessorWorker.new
    # worker.perform('id')
  end
end