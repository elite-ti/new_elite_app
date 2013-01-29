require 'find'
require 'mustard'
require_relative '../../lib/exceptions.rb'
require_relative '../../app/services/decompressor.rb'

describe 'Decompressor' do
  ASSETS_PATH = File.join(File.expand_path(File.dirname(__FILE__)), 'decompressor_assets')
  ZIP_FILE_PATH = File.join(ASSETS_PATH, 'sample.zip')
  RAR_FILE_PATH = File.join(ASSETS_PATH, 'sample.rar')
  NOT_SUPPORTED_FILE_PATH = File.join(ASSETS_PATH, 'sample.not_supported')
  INEXISTENT_FILE_PATH = File.join(ASSETS_PATH, 'inexistent.zip')

  FILENAMES = %w[1.tif 2.tif 3.tif 4.tif 5.tif 6.tif 7.tif 8.tif 9.tif]

  it 'decompresses a zip file and return its filenames' do
    path, file_name = path_and_filename(ZIP_FILE_PATH)
    folder_path = Decompressor.decompress(path, file_name)
    filenames = Find.find(folder_path).select{|f| File.file?(f)}.map{|f| File.basename(f)}
    filenames.sort.must.equal FILENAMES
    FileUtils.rm_r(folder_path)
  end

  it 'decompresses a rar file and return its contents' do
    path, file_name = path_and_filename(RAR_FILE_PATH)
    folder_path = Decompressor.decompress(path, file_name)
    filenames = Find.find(folder_path).select{|f| File.file?(f)}.map{|f| File.basename(f)}
    filenames.sort.must.equal FILENAMES
    FileUtils.rm_r(folder_path)
  end

  it 'raises not supported error' do
    path, file_name = path_and_filename(NOT_SUPPORTED_FILE_PATH)
    expect { Decompressor.decompress(path, file_name) }.
      to raise_error(Exceptions::DecompressorError, Decompressor::NOT_SUPPORTED_MESSAGE)
  end

  it 'raises decompressing file error for inexistent file' do
    path, file_name = path_and_filename(INEXISTENT_FILE_PATH)
    expect { Decompressor.decompress(path, file_name) }.
      to raise_error(Exceptions::DecompressorError, Decompressor::ERROR_DECOMPRESSING_FILE_MESSAGE)
  end

  def path_and_filename(path)
    [path, File.basename(path)]
  end
end