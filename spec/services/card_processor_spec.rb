require 'mustard'
require_relative '../../lib/exceptions.rb'
require_relative '../../app/services/card_processor.rb'
require_relative '../../app/services/decompressor.rb'

describe 'CardProcessor' do
  ASSETS_PATH = File.join(File.expand_path(File.dirname(__FILE__)), 'decompressor_assets')
  ZIP_FILE_PATH = File.join(ASSETS_PATH, 'sample.zip')
  RAR_FILE_PATH = File.join(ASSETS_PATH, 'sample.rar')
  NUMBER_OF_FILES = 9
  FILENAMES = %w[1.tif 2.tif 3.tif 4.tif 5.tif 6.tif 7.tif 8.tif 9.tif]

  it 'creates card processor jobs for based on zip file' do
  end
end