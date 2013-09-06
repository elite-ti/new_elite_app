# encoding: UTF-8

namespace :student do
  task sync_students: :environment do
    client = TinyTds::Client.new(:username => 'temp', :password => '!@elite2012@!', :host => '200.150.153.133')

    # Retrieve list of students (currently enrolled)
    result = client.execute(
     "select distinct
        mat.RA, pes.NOME
      from CORPORERM.dbo.SMATRICPL as mat
        inner join CORPORERM.dbo.SALUNO as alu on alu.RA = mat.RA and alu.CODCOLIGADA = mat.CODCOLIGADA
        inner join CORPORERM.dbo.PPESSOA as pes on alu.CODPESSOA = pes.CODIGO
      order by mat.RA"
    )
    # result = client.execute("select TOP 1 * from CORPORERM.dbo.SMATRICPL") where RECMODIFIEDON > '2013-09-01' or RECCREATEDON > '2013-09-01'
    count = 0
    text_file = []
    result.each do |row|
      if !Student.find_by_ra(row['RA'].to_i).nil? && I18n.transliterate(row['NOME'].strip).upcase != I18n.transliterate(Student.find_by_ra(row['RA'].to_i).name.strip).upcase
        text_file << 'Diferença no RA: ' + row['RA'].to_i.to_s
        text_file << 'Nome EliteSim: ' + I18n.transliterate(Student.find_by_ra(row['RA'].to_i).name.strip).upcase
        text_file << 'Nome RM:       ' + I18n.transliterate(row['NOME'].strip).upcase
        text_file << ''
        std = Student.find_by_ra(row['RA'].to_i)
        std.name = I18n.transliterate(row['NOME'].strip).upcase
        std.save
        count += 1
      end
    end

    CSV.open("/home/deployer/logs/student_update_#{DateTime.now.strftime("%y%m%d_%H%M")}.csv", "wb") do |csv|
      text_file.each do |line|
        csv << [line]
      end
    end    

    p count
    client.close
  end
  
  task sync_enrollments: :environment do
    client = TinyTds::Client.new(:username => 'temp', :password => '!@elite2012@!', :host => '200.150.153.133')
    
    # Retrieve list of enrollments (current ones)
    result = client.execute(
     "select
        mat.RA, pes.NOME as ALUNO, mat.CODTURMA, tur.NOME as TURMA
      from CORPORERM.dbo.SMATRICPL as mat
        inner join CORPORERM.dbo.SALUNO as alu on alu.RA = mat.RA and alu.CODCOLIGADA = mat.CODCOLIGADA
        inner join CORPORERM.dbo.PPESSOA as pes on alu.CODPESSOA = pes.CODIGO
        inner join CORPORERM.dbo.STURMA as tur on mat.CODTURMA = tur.CODTURMA and mat.CODCOLIGADA = tur.CODCOLIGADA
      order by mat.RA"
    )

    enrollments = {}
    result.each do |row|
      if enrollments.keys.include? row['RA']
        enrollments[row['RA']] << translate_klazz(row['CODTURMA'], row['TURMA'])
      else
        enrollments[row['RA']] = [translate_klazz(row['CODTURMA'], row['TURMA'])]
      end
    end

    p enrollments['012938']

    # first = true
    # result.each do |row|
    #   # print table
    #   p row.keys.join(',') if first
    #   p row.values.join(',') + ',' + SuperKlazz.where(translate_klazz(row['CODTURMA'], row['TURMA'])
    #   first = false  
    # end

  # 012938
  end
end

def translate_klazz klazz_code, klazz_name
  klazz_translation = {'1ª SÉRIE ENEM' => '1ª Série ENEM', '1ª SÉRIE MILITAR' => '1ª Série Militar', '2ª SÉRIE ENEM' => '2ª Série ENEM', '2ª SÉRIE MILITAR' => '2ª Série Militar', '3ª SÉRIE AF/EF/ESP' => 'AFA/ESPCEX', '3ª SÉRIE BIOMÉDICA' => 'Pré-Vestibular Biomédicas', '3ª SÉRIE PRÉ-MILITAR' => 'MILITAR', '3ª SÉRIE PRÉ-VESTIBULAR' => 'Pré-Vestibular', '6º ANO' => '6º Ano', '7º ANO' => '7º Ano', '8º ANO' => '8º Ano', '9º ANO FORTE' => '9º Ano Forte', '9º ANO MILITAR' => '9º Ano Militar', 'AF/EE/EF' => 'AFA/EAAr/EFOMM', 'AF/EF/ESP' => 'AFA/ESPCEX', 'AF/EN/EF' => 'AFA/EN/EFOMM', 'CN/EPCAR' => '9º Ano Militar', 'ESPCEX' => 'ESPCEX', 'ESSA' => 'EsSA', 'ET' => '9º Ano Forte', 'IME/ITA' => 'IME-ITA', 'PV' => 'Pré-Vestibular', 'PVBIO' => 'Pré-Vestibular Biomédicas', 'SEM TURMA' => 'SEM TURMA'}
  campus_translation = {'BANGU' => 'Bangu', 'CAMPO GRANDE I' => 'Campo Grande I', 'CAMPO GRANDE II' => 'Campo Grande II', 'ILHA DO GOVERNADOR' => 'Ilha do Governador', 'MADUREIRA I' => 'Madureira I', 'MADUREIRA II' => 'Madureira II', 'MADUREIRA III' => 'Madureira III', 'NORTE SHOPPING' => 'NorteShopping', 'NOVA IGUAÇU' => 'Nova Iguaçu', 'SÃO GONÇALO' => 'São Gonçalo I', 'SÃO GONÇALO I' => 'São Gonçalo I', 'SAO GONÇALO II' => 'São Gonçalo II', 'SÃO GONÇALO II' => 'São Gonçalo II', 'TAQUARA' => 'Taquara', 'TIJUCA' => 'Tijuca', 'VALQUEIRE' => 'Valqueire'}
  campus_name = campus_translation[klazz_name.split(' - ')[1].strip.upcase]
  product_name = klazz_translation[klazz_name.split(' - ')[0].strip.upcase].to_s
  if product_name == "Pré-Vestibular"
    if klazz_name.split(' - ').last.strip == 'MANHÃ'
      product_name = "Pré-Vestibular Manhã"
    elsif klazz_name.split(' - ').last.strip == 'NOITE'
      product_name = "Pré-Vestibular Noite"
    else
      product_name = ''
    end
  elsif product_name == 'MILITAR'
    if !klazz_code.include? "IME"
      if !klazz_code.include? "AF"
        product_name = "ESPCEX"
      else
        product_name = "AFA/ESPCEX"
      end
    else
      product_name = "IME-ITA"
    end
  end
  # p klazz_name.split(' - ')[1].upcase
  # p klazz_code
  product_year_id = ProductYear.find_by_name(product_name.to_s + ' - 2013').id
  campus_id = Campus.find_by_name(campus_name.to_s).id
  sk = SuperKlazz.where(product_year_id: product_year_id, campus_id: campus_id)
  return sk.first
end