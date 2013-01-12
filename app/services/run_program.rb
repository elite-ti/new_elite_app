class RunProgram
  PROGRAMS_PATH = File.join(Rails.root, 'vendor/programs')

  def self.card_scanner(tif_path)
    card_scanner_path = File.join(PROGRAMS_PATH, 'card_scanner/run.sh')

    `bash #{card_scanner_path} #{tif_path}`.strip.split(' ')
  end
end