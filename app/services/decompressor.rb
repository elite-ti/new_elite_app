class Decompressor
  def self.process_files(file_path, extension, &block)
    raise 'File extension not supported.' if not supported?(extension)

    folder_path = `mktemp -d --suffix -decompressor`.chop
    decompress(extension, file_path, folder_path)

    Dir.entries(folder_path).reject do |filename|
      File.directory?(filename)
    end.each do |filename|
      block.call(File.join(folder_path, filename))
    end

    FileUtils.rm_r(folder_path)
  end

private

  def self.supported?(extension)
    extension.in? ['.zip', '.rar']
  end

  def self.decompress(extension, file_path, folder_path)
    case extension 
    when '.zip'
      `unzip #{file_path} -d #{folder_path}`
    when '.rar'
      `unrar e #{file_path}`
    end
  end
end