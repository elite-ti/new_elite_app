require 'find'

class CardProcessor
  def self.run(file, card_type_id, exam_id)
    card_processor = CardProcessor.new(file, card_type_id, exam_id)
  end

private

  def initialize(file, card_type_id, exam_id)
    @file = file
    @card_type_id = card_type_id 
    @exam_id = exam_id 
    pipe
  end
 
  def pipe
    preprocess
    process
    postprocess
  end

  def preprocess
    @folder_path = Decompressor.decompress(@file.path, @file.original_filename)
  end

  def process
    Find.find(@folder_path) do |path|
      next if File.directory?(path) || File.extname(path) != '.tif' 

      student_exam = StudentExam.create_to_be_processed!(
        @exam_id, @card_type_id, File.open(path))
      CardProcessorWorker.perform_async(student_exam.id)
    end
  end

  def postprocess
    FileUtils.rm_r(@folder_path)
  end
end
