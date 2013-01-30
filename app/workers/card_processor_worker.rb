class CardProcessorWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  C_CARD_PROCESSOR_PATH = File.join(Rails.root, 'lib/card_processor/b_type')
  
  def perform(student_exam_id)
    student_exam = StudentExam.find(student_exam_id)
    card_path = student_exam.card.path
    destination_path = File.join(File.dirname(card_path), 'normalized.png')
    parameters = student_exam.card_type.parameters

    process_result = `#{C_CARD_PROCESSOR_PATH} #{card_path} #{destination_path} #{parameters}`
    student_exam.set_process_result(process_result)
  end
end
