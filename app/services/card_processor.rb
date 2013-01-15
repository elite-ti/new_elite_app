class CardProcessor
  CARD_PROCESSOR_PATH = File.join(Rails.root, 'vendor/programs/card_processor')

  def self.normalize(tif_path)

  end

  def self.draw_squares(tif_path)

  end

  def self.scan(tif_path)
    card_scanner_path = File.join(CARD_PROCESSOR_PATH, 'card_scanner/run.sh')

    `bash #{card_scanner_path} #{tif_path}`
  end
end