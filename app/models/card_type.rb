class CardType < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :card, :name, :parameters, :student_coordinates

  has_many :student_exams

  validates :card, :name, :parameters, :student_coordinates, presence: true
  validates :name, uniqueness: true
  validate :parameters_valid?
  validate :student_coordinates_valid?

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

  def is_valid_result?(result)
    configuration.is_valid_result?(result)
  end

private

  def parameters_valid?
    errors.add(:parameters, 'Not valid.') unless CardConfiguration.valid?(parameters) 
  end

  def student_coordinates_valid?
    errors.add(:student_coordinates, 'Not valid.') unless student_coordinates.match(/\d+x\d+\+\d+\+\d/)
  end
end
