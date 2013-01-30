class CardConfiguration
  class MalformedParameters < RuntimeError; end
  class MalformedResult < RuntimeError; end

  attr_reader :threshold, :student_zone, :questions_zone

  def initialize(parameters)
    parse(parameters.split(/\s+/))
  end

  def parse_result(result)
    raise MalformedResult.new if result.size != number_of_questions

    student_result = result[0, student_zone.number_of_questions]
    raise MalformedResult.new unless student_zone.is_valid_result?(student_result)

    questions_result = result[student_zone.number_of_questions, questions_zone.number_of_questions]
    raise MalformedResult.new unless questions_zone.is_valid_result?(questions_result)

    return [student_result, questions_result]    
  end

private

  def parse(parameters)
    raise MalformedParameters.new if parameters.size != 21

    @threshold = parameters[0]
    @student_zone = CardZone.new(parameters[1, 10])
    @questions_zone = CardZone.new(parameters[11, 10])
  end

  def number_of_questions
    student_zone.number_of_questions + questions_zone.number_of_questions
  end
end