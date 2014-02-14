#encoding: utf-8

class EmployeeCsvImportWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(file, email)
    Employee.import(file, email)
  end
end
