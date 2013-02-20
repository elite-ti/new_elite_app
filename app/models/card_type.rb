class CardType < ActiveRecord::Base
  has_paper_trail

  CARD_SCANNER_PATH = File.join(Rails.root, 'lib/card_scanner')
  
  attr_accessible :card, :name, :parameters, :student_coordinates, :command

  has_many :card_processings

  validates :card, :name, :parameters, :student_coordinates, :command, presence: true
  validates :name, uniqueness: true
  validate :parameters_valid?
  validate :student_coordinates_valid?
  validate :command_valid?

  mount_uploader :card, CardTypeUploader

  # parameters example (b type)
  # 0.4 
  # 1 0 7 0123456789 79 38 271 540 964 453 
  # 2 600 50 ABCDE 77 38 170 1054 473 3454

  def configuration
    @configuration ||= CardConfiguration.new(parameters)
  end

  def student_number_length
    configuration.student_zone.number_of_questions
  end

  def question_coordinates(number)
    configuration.questions_zone.questions_coordinates(number)
  end

  def question_alternatives
    configuration.questions_zone.alternatives
  end

  def scan(origin_path, destination_path)
    scan_result = `#{scanner_path} #{origin_path} #{destination_path} #{parameters}`
    configuration.parse_result(scan_result)
  end

private

  def parameters_valid?
    begin
      configuration
    rescue CardConfiguration::InvalidParameters
      errors.add(:parameters, 'not valid.')
    end
  end

  def student_coordinates_valid?
    errors.add(:student_coordinates, 'not valid.') unless student_coordinates.match(/\d+x\d+\+\d+\+\d/)
  end

  def command_valid?
    errors.add(:command, 'not valid.') unless File.exist?(scanner_path)
  end

  def scanner_path
    File.join(CARD_SCANNER_PATH, command, 'bin/run')
  end
end
