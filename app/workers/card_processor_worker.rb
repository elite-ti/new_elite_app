class CardProcessorWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(student_exam_id)
    StudentExam.find(student_exam_id).scan
  end
end
