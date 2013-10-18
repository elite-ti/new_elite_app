class StudentExamCardUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  storage :file

  def store_dir
    if model.id < 31999
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    else
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/" + ("%04d" % (model.id/10000)) + "/#{model.id%10000}"
    end
  end

  def extension_white_list
    %w(tif)
  end

  def filename
    "original.tif" if original_filename
  end

  version :png do
    process convert: :png

    def full_filename(for_file)
      "original.png"
    end
  end

  def normalized_url
    path_to_url(normalized_path)
  end

  def normalized_path
    File.join(folder_path, 'normalized.png')
  end

  def student_url
    create_student_png unless File.exist?(student_path)
    path_to_url(student_path)
  end

  def student_path
    File.join(folder_path, 'student_data.png')
  end

  def question_url(number)
    create_question_png(number) unless File.exist?(question_path(number))
    path_to_url(question_path(number))
  end

  def question_path(number)
    File.join(folder_path, 'question_' + number.to_s + '.png')
  end

private

  def path_to_url(path)
    path.split(public_path)[1]
  end

  def public_path
    File.join(Rails.root, 'public')
  end

  def folder_path
    File.dirname(current_path)
  end

  def create_student_png
    if File.exist? normalized_path
      image = MiniMagick::Image.open(normalized_path)
    else
      image = MiniMagick::Image.open(png.path)
    end
    image.crop model.card_type.student_coordinates
    image.resize '50%'
    image.write student_path
  end

  def create_question_png(number)
    if File.exist? normalized_path
      image = MiniMagick::Image.open(normalized_path)
    else
      image = MiniMagick::Image.open(png.path)
    end
    image.crop model.card_type.question_coordinates(number)
    image.resize '50%'
    image.write question_path(number)
  end
end