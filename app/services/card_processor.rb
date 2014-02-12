#encoding: utf-8
require 'find'

class CardProcessor
  attr_accessor :card_processing

  def initialize(card_processing_id)
    @card_processing = CardProcessing.find(card_processing_id)
  end
  
  def process
    create_student_exams
    scan
    ActionMailer::Base.mail(
      from: 'pensisim@pensi.com.br',
      to: @card_processing.employee.try(:email) || 'pensisim@pensi.com.br',
      subject: "Envio arquivo ##{@card_processing.id}",
      body: <<-eos
      Olá,

      Você acaba de enviar um arquivo para o EliteSim.

      Prova: #{@card_processing.name}
      Data prova: #{@card_processing.exam_date.strftime('%d/%m/%Y')}
      Data Envio: #{@card_processing.created_at.strftime('%d/%m/%Y %H:%M')}
      Unidade: #{@card_processing.campus.name}
      Tipo de Cartão: #{@card_processing.card_type.name}
      Quantidade de cartões: #{@card_processing.student_exams.size}
      Quantidade de erros: #{@card_processing.number_of_errors}

      --
      Central de Resultados
      eos
    ).deliver
  end 

private

  def create_student_exams
    file = card_processing.file
    format = File.extname(file.path)
    if format == '.tif'
      StudentExam.create!(card: File.open(file.path), card_processing_id: card_processing.id)
    elsif %[.rar .zip].include? format
      begin
        folder_path = Decompressor.decompress(file.path)

        counter = 0
        Find.find(folder_path) do |path|
          next if File.directory?(path)
          if File.extname(path) != '.tif' 
            p 'CardProcessor: Not supported format'
            p 'CardProcessingId: ' + card_processing.id.to_s
            p 'File: ' + path
            next
          end
          new_path = File.join(File.dirname(path), counter.to_s + '.tif')
          FileUtils.mv(path, new_path)
          counter = counter + 1
          StudentExam.create!(card: File.open(new_path), card_processing_id: card_processing.id)
        end

        FileUtils.rm_rf(folder_path)
      rescue => e
        p 'Decompressor Error'
        p 'CardProcessingId: ' + card_processing.id.to_s
        p 'Error message: ' + e.message
      end
    end
  end

  def scan
    begin
      card_processing.student_exams.each(&:scan)
      card_processing.processed!
    rescue => e
      p e.message
      card_processing.error!
    end
  end
end