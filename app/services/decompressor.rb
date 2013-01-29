class Decompressor

  NOT_SUPPORTED_MESSAGE = 'Format not supported'
  ERROR_DECOMPRESSING_FILE_MESSAGE = 'Error decompressing file'
  SUPPORTED_FORMATS = %w[rar zip]

  def self.decompress(file_path, filename)
    format = File.extname(filename).reverse.chop.reverse
    raise Exceptions::DecompressorError.new(NOT_SUPPORTED_MESSAGE) unless is_supported?(format)
    
    folder_path = `mktemp -d --suffix -decompressor`.chop
    if send('decompress_' + format, file_path, folder_path)
      return folder_path
    end
    
    FileUtils.rm_r(folder_path)
    raise Exceptions::DecompressorError.new(ERROR_DECOMPRESSING_FILE_MESSAGE)
  end

private

  def self.is_supported?(format)
    SUPPORTED_FORMATS.include? format
  end

  def self.decompress_zip(file_path, folder_path)
    system "unzip #{file_path} -d #{folder_path} > /dev/null 2>&1"
  end

  def self.decompress_rar(file_path, folder_path)
    system "unrar e #{file_path} #{folder_path} > /dev/null 2>&1"
  end
end
