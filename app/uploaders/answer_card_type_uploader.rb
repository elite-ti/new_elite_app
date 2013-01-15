class AnswerCardTypeUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(tif)
  end

  def filename 
    "original.tif" if original_filename
  end 

  version :with_squares do
    process :normalize
    process :draw_squares
    process convert: 'png'

    def full_filename(for_file = model.logo.file) 
      "with_squares.png" 
    end 
  end

  def normalize
    # TODO
  end

  def draw_squares
    # TODO
  end
end
