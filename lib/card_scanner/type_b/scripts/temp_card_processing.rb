# encoding: UTF-8
require 'find'
require 'FileUtils'
require 'mail'
require 'pdf-reader'
require 'csv'
require 'google_drive'

class PdfParser
  def self.parse_pdf(filename)
    elements = {}
    if File.exists? filename.gsub('.pdf','.csv')
      CSV.read("#{filename.gsub('.pdf','.csv')}", encoding: "UTF-8") do |row|
        elements[row[0]] = row[1]
      end
    else
      reader = PDF::Reader.new(filename)
      page = reader.page(1)
      elements = page.text.gsub(/\s\s+/, ',').split(',')
      elements = elements [1..elements.length-2]
      elements = Hash[*elements]
      CSV.open("#{filename.gsub('.pdf','.csv')}", "w") do |io|
        elements.each do |key, value|
          io << [key, value]
        end
      end
    end
    return elements    
  end
end

class Decompressor
  class DecompressorError < RuntimeError; end

  NOT_SUPPORTED_MESSAGE = 'Format not supported'
  ERROR_DECOMPRESSING_FILE_MESSAGE = 'Error decompressing file'
  SUPPORTED_FORMATS = %w[rar zip]

  def self.decompress(file_path)
    format = File.extname(file_path).reverse.chop.reverse
    raise DecompressorError.new(NOT_SUPPORTED_MESSAGE) unless is_supported?(format)
    
    folder_path = `mktemp -d /tmp/foo.XXXXXX`.chop
    
    if send('decompress_' + format, file_path, folder_path)
      return folder_path
    else
      FileUtils.rm_rf(folder_path)
      raise DecompressorError.new(ERROR_DECOMPRESSING_FILE_MESSAGE)
    end
  end

  def self.is_supported?(format)
    SUPPORTED_FORMATS.include? format
  end

private

  def self.decompress_zip(file_path, folder_path)
    #TODO: sanitize data entry though filename
    `unzip '#{file_path}' -d '#{folder_path}'`
  end

  def self.decompress_rar(file_path, folder_path)
    #TODO: sanitize data entry though filename
    `unrar e -or '#{file_path}' '#{folder_path}'`
  end
end


class TempCardProcessing
  attr_accessor :complete_path, :parameters
  attr_accessor :status, :student_number, :string_of_answers, :lines
  BEING_PROCESSED_STATUS = 'Being processed'
  ERROR_STATUS = 'Error'
  STUDENT_NOT_FOUND_STATUS = 'Student not found'
  EXAM_NOT_FOUND_STATUS = 'Exam not found'
  INVALID_ANSWERS_STATUS = 'Invalid answers'
  VALID_STATUS = 'Valid'
  REPEATED_STUDENT = 'Repeated student'
  NEEDS_CHECK = [STUDENT_NOT_FOUND_STATUS, EXAM_NOT_FOUND_STATUS, INVALID_ANSWERS_STATUS]

  def initialize (path, path2)
    @original_path = path
    @status = BEING_PROCESSED_STATUS
    @lines = []
    @run_path = path2
    @parameters = PdfParser.parse_pdf(File.join(File.dirname(@original_path), 'submission.pdf'))
  end

  def processing_parameters
    '0.4 60 540 80 40 1284 4847 1 0 7 0123456789 79 38 271 540 964 453 2 600 50 ABCDE 77 38 170 1054 473 3464'
  end

  def delete_decompressed_folder
    FileUtils.rm_rf(decompressed_path) if is_decompressed?
  end

  def delete_generated_output
    FileUtils.rm(output_path) if has_generated_output?
  end

  def delete_processed_images
    return unless is_decompressed?
    Dir.new(decompressed_path).each do |file|
      FileUtils.rm(File.join(decompressed_path, file)) if File.extname(file) == '.png'
    end
  end

  def clean
    delete_processed_images
    delete_decompressed_folder
    delete_generated_output
  end

  def decompressed_path
    File.join(File.dirname(@original_path),File.basename(@original_path,'.*'))
  end

  def output_path
    File.join(File.dirname(@original_path),'output.csv')
  end

  def is_decompressed?
    File.exists? decompressed_path
  end

  def has_generated_output?
    File.exists? output_path
  end

  def process
    decompress
    process_images
    save_file
  end

  def decompress
    return nil if is_decompressed?
    begin
      temp_path = Decompressor.decompress(@original_path)
      if temp_path.nil?
        puts 'Decompressor Error: Unexpected error.'
      end
      FileUtils.mkdir decompressed_path
      Find.find(temp_path) do |path|
        next if File.directory?(path)
        if File.extname(path) != '.tif'
          puts 'Error on File: ' + path + '(Not supported format)'
          next
        end
        new_path = File.join(decompressed_path,File.basename(path))
        FileUtils.mv(path, new_path)
      end
      FileUtils.rm_rf(temp_path)
    rescue => e
      p 'Decompressor Error :' + e.message
    end
  end

  def process_images
    delete_processed_images
    Dir.new(decompressed_path).each do |image_path|
      next if ['.', '..'].include?(image_path)
      next if File.extname(image_path) != '.tif'
      next if image_path[0..0] == '.'
      normalized_path = File.join(decompressed_path, File.basename(image_path, '.*') + '_normalized.png')
      complete_image_path = File.join(decompressed_path, image_path)
      result = `'#{@run_path}' '#{complete_image_path}' '#{normalized_path}' #{processing_parameters}`
      if is_valid_result(result) 
        @lines << [ image_path, 'Valid', result[0..6], result[7..-1] ]
        print '.'
      else
        @lines << [ image_path, 'Error', '', '' ]
        print '!'
      end
    end
  end

  def save_file
    delete_generated_output if has_generated_output?
    CSV.open(output_path, "wb") do |csv| 
      # csv << [parameters['Cartões-resposta']]
      @lines.each do |line|
        csv << line
      end
    end
  end
end


this_path = File.dirname(File.expand_path(__FILE__))

folder_path = '/Users/pauloacmelo/Google Drive/SCHOOL_CARDS_P1' # TOFILL
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
p "ruby '#{this_path}/../compile.rb'"
`ruby '#{this_path}/../compile.rb'`

# print "=> Removing old files\n"
# `find '#{folder_path}' -name '*.png' -exec rm '{}' \\;`

print "=> Converting to tif\n"
`find '#{folder_path}' -name '*.tif' -exec convert '{}' '{}' \\;`

print "=> Scanning cards\n"
lines = []

Dir.new(folder_path).each do |submission_path|
  next if ['.', '..'].include?(submission_path)
  next if submission_path[0..0] == '.'
  next unless File.directory?(File.join(folder_path, submission_path))
  puts submission_path
  Dir.new(File.join(folder_path, submission_path)).each do |compacted_file_path|
    next if ['.', '..', 'submission.pdf'].include?(compacted_file_path)
    next if File.directory?(File.join(folder_path, submission_path, compacted_file_path))
    next if compacted_file_path[0..0] == '.'
    next if File.extname(compacted_file_path) == '.csv' || File.extname(compacted_file_path) == '.xls'
    puts " * " + compacted_file_path
    temp = TempCardProcessing.new(File.join(folder_path, submission_path, compacted_file_path), this_path + '/../bin/run')
    # temp.clean
    temp.process
  end
  puts ''
end