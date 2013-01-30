require 'mustard'
require_relative '../../app/services/card_processor.rb'
require_relative '../../app/services/decompressor.rb'

describe 'CardProcessor' do
  assets_file_path = File.join(File.expand_path(File.dirname(__FILE__)), 'decompressor_assets')
  zip_file_path = File.join(assets_file_path, 'sample.zip')
  rar_file_path = File.join(assets_file_path, 'sample.rar')
  number_of_files = 9
  filenames = %w[1.tif 2.tif 3.tif 4.tif 5.tif 6.tif 7.tif 8.tif 9.tif]

  it 'creates card processor jobs for based on zip file' do
  end
end