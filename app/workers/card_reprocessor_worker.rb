#encoding: utf-8

class CardReprocessorWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(card_processing_id)
    card_processor = CardProcessor.new(card_processing_id)
    card_processor.reprocess
  end
end
