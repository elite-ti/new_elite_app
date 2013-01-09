class Uncompressor
  def self.supported_extensions
    ['.zip', '.rar']
  end

  def initialize(file_path)
    @file_path = file_path
    @folder_path = `mktemp -d --suffix -uncompressor`.chop
    uncompress
  end

  def get_files
    Dir.entries(@folder_path).select do |file|
      File.extname(file) == '.tif'
    end
  end

  def destroy_files
    `rm -r #{@folder_path}`
  end

private

  def set_folder_path

  end

  def uncompress
    if File.extname(@file_path) == '.zip'
      `unzip #{@file_path} -d #{@folder_path}`
    elsif File.extname(@file_path) == '.rar'
      `unrar e #{@file_path}`
    end
  end
end