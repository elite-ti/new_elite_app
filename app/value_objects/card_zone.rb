class CardZone
  DEFAULT_CHARACTERS = %w[W Z]

  attr_reader :alternatives

  def initialize(parameters)
    parse(parameters) 
  end

  def is_valid_result?(partial_result)
    number_of_questions == partial_result.size && 
      only_permitted_characters?(partial_result)
  end

  def number_of_questions
    @number_of_groups * @questions_per_group
  end

  def questions_coordinates(number)
    delta = 100
    question_width = @group_width + delta
    question_height = @group_height/@questions_per_group

    question_x = @group_x + (number/@questions_per_group)*@space_between_groups - delta + 10

    question_y = @group_y + ((@group_height - @option_height).to_f/(@questions_per_group - 1))*(number - 1)

    "#{question_width}x#{question_height}+#{question_x}+#{question_y}"
  end

private

  def parse(parameters)
    raise CardConfiguration::InvalidParameters.new if parameters.size != 10

    @number_of_groups = parameters[0].to_i
    @space_between_groups = parameters[1].to_i
    @questions_per_group = parameters[2].to_i
    @alternatives = parameters[3].split(//)
    @option_width = parameters[4].to_i
    @option_height = parameters[5].to_i
    @group_x = parameters[6].to_i
    @group_y = parameters[7].to_i
    @group_width = parameters[8].to_i
    @group_height = parameters[9].to_i
  end

  def only_permitted_characters?(partial_result)
    partial_result.each_char do |char|
      return false unless (@alternatives + DEFAULT_CHARACTERS).include? char
    end
    true
  end
end