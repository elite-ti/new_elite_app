# encoding: UTF-8

namespace :teacher do
  task create_reports: :environment do
    # type = 'Instrutor'
    # general_file = '/Users/pauloacmelo/Downloads/gdparquivoscsv/instrutores_geral.csv'
    # specific_file = '/Users/pauloacmelo/Downloads/gdparquivoscsv/instrutores_unidade.csv'

    type = 'Monitor'
    general_file = '/Users/pauloacmelo/Downloads/gdparquivoscsv/monitores_geral.csv'
    specific_file = '/Users/pauloacmelo/Downloads/gdparquivoscsv/monitores_atividade.csv'

    general_data = {}
    specific_data = {}

    CSV.foreach(general_file, :headers => true, :header_converters => :symbol, :converters => :all) do |row|
      general_data[row.fields[0]] = Hash[row.headers[1..-1].zip(row.fields[1..-1])]
    end

    CSV.foreach(specific_file, :headers => true) do |row|
      specific_data[row.fields[0]] = [] if specific_data[row.fields[0]].nil?
      specific_data[row.fields[0]] << Hash[row.headers[1..-1].zip(row.fields[1..-1])]
    end

    # p general_data
    p specific_data

    # abort("No results were returned for that query")

    pdf_folder = File.join(Rails.root, "public/reports/#{type}")
    images_folder = File.join(Rails.root, 'public/images')

    `mkdir #{pdf_folder}`  if !File.exists?(pdf_folder)
    `mkdir #{images_folder}`  if !File.exists?(images_folder)

    general_data.each do |key, value|
      next if value[:nome_professor].nil?
      pdf = TeachingAssistantPrawn.new(type, value, specific_data[key.to_s], images_folder)
      pdf.render_file("#{File.join(pdf_folder, value[:nome_professor] + '.pdf')}")
    end    

  end
end