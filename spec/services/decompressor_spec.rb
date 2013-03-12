require 'find'
require_relative '../../app/services/decompressor.rb'

describe Decompressor do
  assets_path = File.join(File.expand_path(File.dirname(__FILE__)), 'decompressor_assets')

  zip_file_path = File.join(assets_path, 'sample.zip')
  rar_file_path = File.join(assets_path, 'sample.rar')
  FILENAMES = %w[1.tif 2.tif 3.tif 4.tif 5.tif 6.tif 7.tif 8.tif 9.tif]

  repeated_zip_file_path = File.join(assets_path, 'repeated.zip')
  repeated_rar_file_path = File.join(assets_path, 'repeated.rar')
  REPEATED_RAR_FILENAMES = %w[1(1).tif 1.tif]
  REPEATED_ZIP_FILENAMES = %w[1.tif 1.tif]

  not_supported_file_path = File.join(assets_path, 'sample.not_supported')
  inexistent_file_path = File.join(assets_path, 'inexistent.zip')

  context 'when decompressing a .zip' do 
    it 'returns its contents' do
      folder_path = Decompressor.decompress(zip_file_path)
      filenames = Find.find(folder_path).select{|f| File.file?(f)}.map{|f| File.basename(f)}
      filenames.sort.should == FILENAMES
      FileUtils.rm_r(folder_path)
    end

    it 'returns its contents even with repeated files' do
      folder_path = Decompressor.decompress(repeated_zip_file_path)
      filenames = Find.find(folder_path).select{|f| File.file?(f)}.map{|f| File.basename(f)}
      filenames.sort.should == REPEATED_ZIP_FILENAMES
      FileUtils.rm_r(folder_path)
    end
  end

  context 'when decompressing a .rar' do 
    it 'returns its contents' do
      folder_path = Decompressor.decompress(rar_file_path)
      filenames = Find.find(folder_path).select{|f| File.file?(f)}.map{|f| File.basename(f)}
      filenames.sort.should == FILENAMES
      FileUtils.rm_r(folder_path)
    end

    it 'return its contents even with repeated files' do
      folder_path = Decompressor.decompress(repeated_rar_file_path)
      filenames = Find.find(folder_path).select{|f| File.file?(f)}.map{|f| File.basename(f)}
      filenames.sort.should == REPEATED_RAR_FILENAMES
      FileUtils.rm_r(folder_path)
    end
  end

  it 'raises not supported error' do
    expect { Decompressor.decompress(not_supported_file_path) }.
      to raise_error(Decompressor::DecompressorError, Decompressor::NOT_SUPPORTED_MESSAGE)
  end

  it 'raises decompressing file error for inexistent file' do
    expect { Decompressor.decompress(inexistent_file_path) }.
      to raise_error(Decompressor::DecompressorError, Decompressor::ERROR_DECOMPRESSING_FILE_MESSAGE)
  end
end