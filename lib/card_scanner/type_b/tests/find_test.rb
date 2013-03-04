# encoding: UTF-8

require 'find'

def print_results(file, result)
  2.times { print "\n" }
  print 'File:   ' + file + "\n"
  print 'Result: ' + result + "\n"
end


this_path = File.dirname(File.expand_path(__FILE__))

parameters = '0.4 60 540 80 40 1284 4847 1 0 7 0123456789 79 38 271 540 964 453 2 600 50 ABCDE 77 38 170 1054 473 3464'
folder_path = '/home/charlie/Desktop/understading_cards/cards_per_campus/Bangu'
errors = []
file_to_be_processed_format = '.tif'

print "=> Compiling card scanner\n"
`ruby #{this_path}/../compile.rb`

print "=> Removing old files\n"
`find #{folder_path} -name '*.png' -exec rm '{}' \\;`

print "=> Converting to tif\n"
`find #{folder_path} -name '*.tif' -exec convert '{}' '{}' \\;`

print "=> Scanning cards\n"

begin
  Find.find(folder_path) do |file_path|
    next if File.extname(file_path) != file_to_be_processed_format

    normalized_path = File.join(File.dirname(file_path), 
      File.basename(file_path, file_to_be_processed_format) + '_normalized.png')

    result = `#{this_path}/../bin/run '#{file_path}' '#{normalized_path}' #{parameters}`

    if result[0, 7] == '9131501'
      print_results(file_path, result)
    else
      print 'F'
      errors << [file_path, result]
    end
  end

rescue => e
  print "\n" + e.message + "\n"

ensure
  print "\n=> Errors:\n\n"
  errors.each do |error|
    print_results(*error)
  end
end