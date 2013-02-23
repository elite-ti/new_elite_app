class CardProcessorWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(card_processing_id)
    # CardProcessing.find(card_processing_id).scan
  end
end
