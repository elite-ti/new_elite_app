require 'spec_helper'

describe 'Uncompressor' do
  SAMPLES_PATH = "#{Rails.root}/spec/services/"
  FILES_LIST = ['a.tif', 'b.tif', 'c.tif']

  # it 'uncompress a zip file and return its contents' do
  #   uncompressor = Uncompressor.new(File.join(SAMPLES_PATH, 'sample.rar'))
  #   uncompressor.get_files.must.equal FILES_LIST
  # end

  # it 'uncompress a rar file and return its contents' do
  #   uncompressor = Uncompressor.new(File.join(SAMPLES_PATH, 'sample.zip'))
  #   uncompressor.get_files.must.equal ['a', 'b', 'c', 'd', 'e']
  # end
end