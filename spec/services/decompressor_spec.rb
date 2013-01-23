require 'spec_helper'

describe 'Decompressor' do
  ZIP_FILE_PATH = "#{Rails.root}/spec/support/sample.zip"
  RAR_FILE_PATH = "#{Rails.root}/spec/support/sample.rar"
  FILENAMES = %w[1.tif 2.tif 3.tif 4.tif 5.tif 6.tif 7.tif 8.tif 9.tif]

  it 'decompresses a zip file and return its filenames' do
    filenames = []    
    Decompressor.process_files(ZIP_FILE_PATH, '.zip') do |filename|
      filenames << File.basename(filename)
    end
    filenames.sort.must.equal FILENAMES
  end

  it 'decompresses a rar file and return its contents' do
    filenames = []    
    Decompressor.process_files(RAR_FILE_PATH, '.rar') do |filename|
      filenames << File.basename(filename)
    end
    filenames.sort.must.equal FILENAMES
  end
end