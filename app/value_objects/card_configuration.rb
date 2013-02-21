class CardConfiguration
  class InvalidParameters < RuntimeError; end
  class InvalidResult < RuntimeError; end

  attr_reader :threshold, :student_zone, :questions_zone

  def initialize(parameters)
    parse(parameters.split(/\s+/))
  end

  def parse_result(result)
    raise InvalidResult.new('wrong number of questions') if result.size != number_of_questions

    student_result = result[0, student_zone.number_of_questions]
    raise InvalidResult.new('wrong student answers') unless student_zone.is_valid_result?(student_result)

    questions_result = result[student_zone.number_of_questions, questions_zone.number_of_questions]
    raise InvalidResult.new('wrong questions answers') unless questions_zone.is_valid_result?(questions_result)

    return [student_result, questions_result]    
  end

private

  def parse(parameters)
    raise InvalidParameters.new if parameters.size != 27

    @threshold = parameters[0]
    @pivot_default_x = parameters[1]
    @pivot_default_y = parameters[2]
    @mark_width = parameters[3]
    @mark_height = parameters[4]
    @default_card_width = parameters[5]
    @default_card_height = parameters[6]

    @student_zone = CardZone.new(parameters[7, 10])
    @questions_zone = CardZone.new(parameters[17, 10])
  end

  def number_of_questions
    student_zone.number_of_questions + questions_zone.number_of_questions
  end
end