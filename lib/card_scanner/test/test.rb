require 'find'
require 'debugger'

ANSWERS_PATH = '/home/charlie/Desktop/card_processor_assets/answers'
CARDS_PATH = '/home/charlie/Desktop/card_processor_assets/cards'

B_TYPE_PROCESOR = '/home/charlie/code/new_elite_app/vendor/programs/card_processor/b_type'

class Answer
  attr_reader :student, :answers

  def initialize(line)
    line = line.chomp
    line = line.chop.chop if line.end_with?('||')
    line = line.chop if line.size == 108

    @student = line[0, 7]
    @answers = line[7, line.length - 7]
  end

  def to_s
    @student + @answers
  end
end

p 'Loading expected answers'
expected_answers = []
Find.find(ANSWERS_PATH) do |path|
  next if File.directory?(path) || File.extname(path) != '.DAT'

  File.open(path, "r:iso-8859-1"){|f| f.read }.lines.each do |line|
    expected_answers << Answer.new(line)  
  end
end

p 'Compiling card processor'
`rm -f b_type`
`gcc -std=c99 b_type.c lodepng.c -lm -o b_type`

errors = 0
successes = 0

p 'Executing tests'
tmp_file = `mktemp --suffix .png`.chop
Find.find(CARDS_PATH) do |path|
  next if File.directory?(path) || File.extname(path) != '.tif'

  path = path.gsub(/\s/, "\\\s")
  `convert #{path} #{tmp_file}`
  destination_path = File.join(File.dirname(path), 'normalized_' + File.basename(path, '.tif') + '.png')
  result = Answer.new(`#{B_TYPE_PROCESOR} #{tmp_file} #{destination_path}`)
  expected_answer = expected_answers.select {|x| x.student == result.student }

  if expected_answer.size == 0
    p "=> Error: Student not found"
    p "File: " + path
    p "Result: " + result.to_s
    errors = errors.next
  elsif expected_answer.size > 1
    expected_answer = expected_answers.select {|x| x.to_s == result.to_s }
    if expected_answer.size == 0
      p "=> Error: Student was found, but answers are not the same"
      p "File: " + path
      p "Result: " + result.to_s
      errors = errors.next
    else
      p "=> Success!"
      successes = successes.next
    end
  else
    expected_answer = expected_answer.first
    if result.answers == expected_answer.answers
      p "=> Success!"
      successes = successes.next
    else
      p "=> Error"
      p "File: " + path
      p "Expected: " + expected_answer.to_s
      p "Result: " + result.to_s
      errors = errors.next
    end
  end
end
`rm #{tmp_file}`
p 'Number of errors: ' + errors.to_s
p "Number of successes: " + successes.to_s
