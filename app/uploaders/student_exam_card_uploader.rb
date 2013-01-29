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
    process convert: :png

    def full_filename(for_file)
      "original.png"
    end
  end

  def normalized_url
    path_to_url(normalized_path)
  end

  def student_name_url
    create_student_name_png unless File.exist?(student_name_path)
    path_to_url(student_name_path)
  end

  def question_url(number)
    create_png(number) unless File.exist?(question_path(number))
    path_to_url(question_path(number))
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

  def normalized_path
    File.join(folder_path, 'normalized.png')
  end

  def student_name_path
    File.join(folder_path, 'student_name.png')
  end

  def question_path(number)
    File.join(folder_path, 'question_' + number.to_s + '.png')
  end

  def create_student_name_png
    image = MiniMagick::Image.open(normalized_path)
    image.crop '845x280+398+35'
    image.resize '50%'
    image.write student_name_path
  end

  def create_png(number)
    image = MiniMagick::Image.open(normalized_path)

    width = 590
    height = 70
    x = number <= 50 ? 66 : 664
    y = 1038 + height*(number - 1)

    image.crop "#{width}x#{height}+#{x}+#{y}"
    image.resize '50%'
    image.write question_path(number)
  end
end