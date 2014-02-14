#encoding: utf-8

class ExamCsvImportWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(file, email)
    Exam.import(file, email)
  end
end
