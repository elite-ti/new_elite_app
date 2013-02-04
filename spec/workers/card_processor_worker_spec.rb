require 'sidekiq'
require_relative '../../app/workers/card_processor_worker.rb'

class StudentExam; end

describe 'CardProcessorWorker' do  
  it 'performs task' do
    student_exam = stub(:scan)
    StudentExam.stub(:find) { student_exam }

    student_exam.should_receive(:scan).once

    worker = CardProcessorWorker.new
    worker.perform(nil)
  end
end