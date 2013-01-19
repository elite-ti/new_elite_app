class StudentExamCardUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(tif)
  end

  def filename 
    "original.tif"
  end

  version :png do
    process :convert => :png

    def full_filename(for_file)
      "original.png"
    end
  end
end
