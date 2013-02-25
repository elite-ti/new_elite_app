class Decompressor

  class DecompressorError < RuntimeError; end

  NOT_SUPPORTED_MESSAGE = 'Format not supported'
  ERROR_DECOMPRESSING_FILE_MESSAGE = 'Error decompressing file'
  SUPPORTED_FORMATS = %w[rar zip]

  def self.decompress(file_path)
    format = File.extname(file_path).reverse.chop.reverse
    raise DecompressorError.new(NOT_SUPPORTED_MESSAGE) unless is_supported?(format)
    
    folder_path = `mktemp -d`.chop
    
    if send('decompress_' + format, file_path, folder_path)
      return folder_path
    else
      FileUtils.rm_rf(folder_path)
      raise DecompressorError.new(ERROR_DECOMPRESSING_FILE_MESSAGE)
    end
  end

  def self.is_supported?(format)
    SUPPORTED_FORMATS.include? format
  end

private

  def self.decompress_zip(file_path, folder_path)
    system "unzip #{file_path} -d #{folder_path} > /dev/null 2>&1"
  end

  def self.decompress_rar(file_path, folder_path)
    system "unrar e #{file_path} #{folder_path} > /dev/null 2>&1"
  end
end
