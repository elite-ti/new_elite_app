#encoding: utf-8

class StudentCsvImportWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(file)
    p 'PARA TUDO'
    p 'file'
    Student.import(file)
  end
end
