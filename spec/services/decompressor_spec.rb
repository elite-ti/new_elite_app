require 'find'
require_relative '../../app/services/decompressor.rb'

describe Decompressor do
  assets_path = File.join(File.expand_path(File.dirname(__FILE__)), 'decompressor_assets')
  zip_file_path = File.join(assets_path, 'sample.zip')
  rar_file_path = File.join(assets_path, 'sample.rar')
  not_supported_file_path = File.join(assets_path, 'sample.not_supported')
  inexistent_file_path = File.join(assets_path, 'inexistent.zip')

  FILENAMES = %w[1.tif 2.tif 3.tif 4.tif 5.tif 6.tif 7.tif 8.tif 9.tif]

  it 'decompresses a zip file and return its filenames' do
    path, file_name = path_and_filename(zip_file_path)
    folder_path = Decompressor.decompress(path, file_name)
    filenames = Find.find(folder_path).select{|f| File.file?(f)}.map{|f| File.basename(f)}
    filenames.sort.should == FILENAMES
    FileUtils.rm_r(folder_path)
  end

  it 'decompresses a rar file and return its contents' do
    path, file_name = path_and_filename(rar_file_path)
    folder_path = Decompressor.decompress(path, file_name)
    filenames = Find.find(folder_path).select{|f| File.file?(f)}.map{|f| File.basename(f)}
    filenames.sort.should == FILENAMES
    FileUtils.rm_r(folder_path)
  end

  it 'raises not supported error' do
    path, file_name = path_and_filename(not_supported_file_path)
    expect { Decompressor.decompress(path, file_name) }.
      to raise_error(Decompressor::DecompressorError, Decompressor::NOT_SUPPORTED_MESSAGE)
  end

  it 'raises decompressing file error for inexistent file' do
    path, file_name = path_and_filename(inexistent_file_path)
    expect { Decompressor.decompress(path, file_name) }.
      to raise_error(Decompressor::DecompressorError, Decompressor::ERROR_DECOMPRESSING_FILE_MESSAGE)
  end

  def path_and_filename(path)
    [path, File.basename(path)]
  end
end