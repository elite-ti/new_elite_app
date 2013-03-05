# encoding: UTF-8

require 'find'

this_path = File.dirname(File.expand_path(__FILE__))

parameters = '0.4 60 540 80 40 1284 4847 1 0 7 0123456789 79 38 271 540 964 453 2 600 50 ABCDE 77 38 170 1054 473 3464'
folder_path = '/home/charlie/Desktop/samples' # TOFILL
file_to_be_processed_format = '.tif'

def is_valid_result(result)
  result.split('').uniq.each do |c|
    unless %w[A B C D E W Z 0 1 2 3 4 5 6 7 8 9].include? c
      return false
    end
  end
  true
end

print "=> Compiling card scanner\n"
`ruby #{this_path}/../compile.rb`

print "=> Removing old files\n"
`find #{folder_path} -name '*.png' -exec rm '{}' \\;`

print "=> Converting to tif\n"
`find #{folder_path} -name '*.tif' -exec convert '{}' '{}' \\;`

print "=> Scanning cards\n"
lines = []

Find.find(folder_path) do |file_path|
  next if File.extname(file_path) != file_to_be_processed_format

  normalized_path = File.join(File.dirname(file_path), 
    File.basename(file_path, file_to_be_processed_format) + '_normalized.png')

  result = `#{this_path}/../bin/run '#{file_path}' '#{normalized_path}' #{parameters}`

  if is_valid_result(result) 
    lines << 'Valid => ' + result + "\n"
  else
    lines << 'Error => ' + "\n"
    lines << 'File:   ' + file_path + "\n"
    lines << 'Result: ' + result + "\n"
  end
end

File.open("#{folder_path}/../scanner_result.txt", 'w') do |f2|  
  lines.each do |line|
    f2.puts line
  end
end 