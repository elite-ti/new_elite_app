class Decompressor
  def self.process_files(file_path, extension, &block)
    decompressor = Decompressor.new(file_path, extension, block)
    decompressor.process_files
  end

  def initialize(file_path, extension, block)
    @file_path = file_path
    @extension = extension
    @block = block
  end

  def process_files
    raise 'File extension not supported.' if not is_supported?

    decompress
    Dir.glob(File.join(@folder_path, "**", "*.tif")) do |filename|
      @block.call(filename)
    end
    remove_folder
  end

private

  def is_supported?
    @extension.in? ['.zip', '.rar']
  end

  def decompress
    @folder_path = `mktemp -d --suffix -decompressor`.chop

    case @extension 
    when '.zip'
      `unzip #{@file_path} -d #{@folder_path}`
    when '.rar'
      `unrar e #{@file_path} #{@folder_path}`
    end
  end

  def remove_folder
    FileUtils.rm_r(@folder_path)
  end
end