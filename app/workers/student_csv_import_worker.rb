#encoding: utf-8

class StudentCsvImportWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(file, email)
    Student.import(file, email)
  end
end
