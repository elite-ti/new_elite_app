class CardConfiguration
  attr_reader :threshold, :student_zone, :questions_zone

  def self.valid?(parameters)
    begin
      CardConfiguration.new(parameters)
    rescue
      return false
    end
    true
  end

  def initialize(parameters)
    parse(parameters.split(/\s+/))
  end

  def is_valid_result?(result)
    return false if result.size != number_of_questions

    student_result = result[0, student_zone.number_of_questions]
    questions_result = result[student_zone.number_of_questions, questions_zone.number_of_questions]

    student_zone.is_valid_result?(student_result) && questions_zone.is_valid_result?(questions_result)
  end

private

  def parse(parameters)
    raise 'Invalid parameters' if parameters.size != 21

    @threshold = parameters[0]
    @student_zone = CardZone.new(parameters[1, 10])
    @questions_zone = CardZone.new(parameters[11, 10])
  end

  def number_of_questions
    student_zone.number_of_questions + questions_zone.number_of_questions
  end
end