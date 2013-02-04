require_relative '../../app/services/card_processor.rb'

class Decompressor; end
class CardProcessorWorker; end
class StudentExam; end

describe 'CardProcessor' do
  it 'creates card processor jobs based on zip file' do
    file = stub(:path => 'path', 
        :original_filename => 'filename.zip')
    Decompressor.stub(:decompress) { stub }
    
    Find.stub(:find).
        and_yield('one.tif').
        and_yield('two.tif').
        and_yield('dir')

    File.stub(:directory?).and_return(false, false, true)
    File.stub(:extname).and_return('.tif', '.tif', '')

    student_exam = stub(:id => 'anything')
    StudentExam.stub(:create_to_be_processed!) { student_exam }

    FileUtils.stub(:rm_r)

    CardProcessorWorker.should_receive(:perform_async).twice
    CardProcessor.run(file, nil, nil)
  end
end