#encoding: utf-8

class CardProcessorWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(card_processing_id)
    card_processor = CardProcessor.new(card_processing_id)
    card_processor.process
  end
end
