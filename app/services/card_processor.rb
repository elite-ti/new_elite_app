class CardProcessor
  CARD_PROCESSOR_PATH = File.join(Rails.root, 'vendor/programs/card_processor')

  def self.draw_squares(tif_path)
    # TODO
  end

  def self.scan(tif_path)
    b_type = File.join(CARD_PROCESSOR_PATH, 'b_type')
    `#{b_type} #{tif_path} /home/charlie/Desktop/out.png`
  end
end