# encoding: UTF-8

namespace :student do
  task create_attendance_lists: :environment do
    if ENV['BOLSAO_DATE'].nil?
      bolsao_id = ENV['BOLSAO_ID'].to_i
      `mkdir #{File.join(Rails.root,'public/lists')}`  if !File.exists?(File.join(Rails.root,'public/lists'))
      Applicant.where(bolsao_id: bolsao_id).group_by{|a| [a.group_name, a.exam_campus_id]}.each do |k, v|
        pdf = AttendanceListPrawn.new(nil, bolsao_id, k[0], k[1])
        filename = File.join(Rails.root,'public/lists', 'ListaPresença - ' + Campus.find(k[1]).name + ' - ' + k[0] + '.pdf')
        pdf.render_file(filename)
      end
    else
      date = ENV['BOLSAO_DATE'].to_date
      `mkdir #{File.join(Rails.root,'public/lists')}`  if !File.exists?(File.join(Rails.root,'public/lists'))
      ExamCycle.where(is_bolsao: true).map(&:exam_executions).flatten.select{|e| e.datetime.to_date == date}.uniq.each do |exam_execution|
        p exam_execution.full_name
        pdf = AttendanceListPrawn.new(exam_execution.id)
        filename = File.join(Rails.root,'public/lists', 'ListaPresença - ' + exam_execution.full_name.split('-')[3].strip + ' - ' + exam_execution.super_klazz.campus.name + ' - ' + exam_execution.super_klazz.product_year.product.name.gsub(/\//,'-') + '.pdf')
        pdf.render_file(filename)
      end
    end
  end

  task select_table: :environment do
    client = Mysql2::Client.new(
      # :host => "mysql.sistemaeliterio.com.br", 
      :host => "189.38.85.61", 
      :database => "sistemaeliteri04",
      :username => "sistemaeliteri04",
      :encoding => 'latin1',
      :password => "2elite29sistema95"
    )

    results = client.query("SELECT * from wp_bolsao")
    # results = client.query("SELECT wp_rel_segmento_turma.*, wp_rel_bolsao_segmento.*, wp_bolsoes_opcao.* FROM wp_rel_segmento_turma " + 
    #                         "inner join wp_rel_bolsao_segmento on wp_rel_bolsao_segmento.id = wp_rel_segmento_turma.rel_id " + 
    #                         "inner join wp_bolsoes_opcao on wp_bolsoes_opcao.tipo = 'turma' and wp_bolsoes_opcao.id = wp_rel_segmento_turma.opcao_id"
    #                       )
    first = true
    results.each do |row|
      if first
        first = false
        p row.keys.join ','
      end
      p row.values.join ','
    end
  end

  task sync_applicants: :environment do
    # create client for communicating with remote database
    client = Mysql2::Client.new(
      :host => "mysql.sistemaeliterio.com.br", 
      :database => "sistemaeliteri04",
      :username => "sistemaeliteri04",
      :encoding => 'utf8',
      :password => "2elite29sistema95"
    )

    # get id bolsao
    p 'Bolsao #' + ENV['BOLSAO_ID'].to_s
    bolsao_id = ENV['BOLSAO_ID'].to_i

    # run query to get all applicants
    p 'Running query:'
    p "SELECT * FROM wp_inscricao_bolsao_2014 where bolsao = #{bolsao_id}"
    results = client.query("SELECT * FROM wp_inscricao_bolsao_2014 where bolsao = #{bolsao_id}")

    # iterate over results
    ignored = []
    to_ignore = [20513,20526,20527,20535,20537,20551,20569,20577,20590,20595,20613,20661,20671,20705,20729,20735,20806,20827,20838,20844,20855,20863,20883,20887,20905,20917,20918,20929,20970,20971,20976,20983,20989,20999,21004,21011,21013,21026,21049,21061,21070,21073,21077,21101,21116,21131,21134,21174,21216,21249,21255,21267,21283,21284,21294,21302,21311,21314,21340,21360,21389,21404,21411,21428,21463,21465,21492,21500,21514,21517,21561,21584,21614,21619,21670,21709,21722,21748,21815,21821,21848,21863,21887,21890,21907,21908,21934,21939,21941,21949,21965,21997,22005,22017,22020,22040,22051,22064,22072,22084,22099,22102,22103,22104,22168,22170,22180,22183,22190,22209,22215,22232,22237,22244,22250,22263,22306,22307,22423,22431,22437,22442,22458,22484,22494,22496,22499,22518,22541,22591,22597,22608,22621,22622,22656,22658,22662,22665,22672,22700,22738,22767,22830,22839,22871,22874,22895,22932,22937,22944,22961,22968,22997,23039,23049,23092,23096,23109,23148,23157,23163,23175,23231,23236,23240,23261,23265,23322,23330,23348,23360,23370,23381,23384,23389,23411,23419,23428,23436,23454,23485,23488,23522,23572,23624,23625,23653,23656,23682,23689,23724,23765,23798,23800,23806,23807,23838]     
    existent_numbers = Applicant.all.map(&:number)
    results.each do |row|
      # p ''
      
      next if to_ignore.include? row["id"]

      # skip bad rows
      if !row["nome_candidato"].present? || !row["turma"].present? || !row["unidade"].present? || !row["horario"].present?
        p "   Skipped Applicant number ##{row["id"]} for lack of some field"
        p row
        next
      end

      # adjust column turma for pré-vest cases
      if ['Pré-Vestibular ', '3ª Série + Pré-Vestibular '].include? translate(row['turma'])
        row['turma'] = row['turma'] + row['turno']
      elsif ['Pré-Vestibular', '3ª Série + Pré-Vestibular'].include? translate(row['turma'])
        row['turma'] = row['turma'] + ' ' + row['turno']
      end

      # check database existance
      
      next if existent_numbers.include? row["id"]

      # translate remote database's strings to local ids
      campus_id = Campus.where("name like '%#{translate(row['unidade'].strip)}'").map(&:id)
      product_year_id = ProductYear.where("name like '#{translate(row['turma'].strip)} - 2014'").map(&:id) || -1
      sk_ids = SuperKlazz.where(product_year_id: product_year_id, campus_id: campus_id).map(&:id)
      ees = ExamExecution.where(exam_cycle_id: ExamCycle.where(is_bolsao: true).where("name like '%Bolsão 2014 -  #{translate(row['horario'].strip)}%'").map(&:id).uniq, super_klazz_id: sk_ids || -1)

      # applicant should have only one super_klazz
      if sk_ids.size == 0
        p '   Found no klazz for him'
        campus_id = Campus.where("name like '%#{translate(row['unidade'].strip)[0..-3]}%'").map(&:id)
        p campus_id
        product_year_id = ProductYear.where("name like '%#{translate(row['turma'].strip)}% - 2014' and not (name like '%3_ S_rie + %')").map(&:id) || -1
        p product_year_id
        sk_ids = SuperKlazz.where(product_year_id: product_year_id, campus_id: campus_id).map(&:id)
        p sk_ids.map{|id| SuperKlazz.find(id).name}.join(',')
        p row
        # break if sk_ids.size != 1
        p '   Managed it!'
      elsif sk_ids.size > 1
        p '   Found more than one klazz for him: ' + sk_ids.map{|id| SuperKlazz.find(id).name}.join(',')
        p row
        # break
      end

      # create student
      std = Student.new(
        email: row["email"],
        name: row["nome_candidato"],
        cpf: row["cpf_candidato"] || row["cpf_responsavel"],
        own_cpf: row["responsavel"].to_i == 1,
        date_of_birth: row["data_nascimento"],
        number_of_children: row["dependentes_responsavel"],
        mother_name: (row["parentesco_responsavel"] == 'Mãe' ? row["nome_responsavel"] : nil),
        father_name: (row["parentesco_responsavel"] == 'Pai' ? row["nome_responsavel"] : nil),
        telephone: row["celular_candidato"],
        cellphone: row["telefone"]
      )
      std.save

      # create applicant
      applicant = Applicant.new(
        number: row["id"].to_i,
        subscription_datetime: row["data_inscricao"].to_datetime,
        exam_datetime: (row["data_bolsao"].to_s + ' ' + row["horario"].to_s).to_datetime,
        exam_campus_id: campus_id.first,
        student_id: std.id,
        bolsao_id: bolsao_id,
        super_klazz_id: sk_ids.first
      )
      applicant.save
      p "   Created applicant ##{applicant.number}"
    end
    p ignored
    client.close
  end

  task create_applicants: :environment do    
    p 'Reading file...'
    # Read file with all applicants info
    results = []
    CSV.foreach('/Users/pauloacmelo/Downloads/PS_Monitores.txt', :headers => true, :converters => :all) do |row|
      results << Hash[row.headers.zip(row.fields)]
    end

    bolsao_id = ENV['BOLSAO_ID'].to_i
    if ENV['BOLSAO_ID'].nil?
      bolsao_id = 0
      bolsao_id += 1 while Applicant.where(bolsao_id: bolsao_id).any?
    end
    existent_numbers = Applicant.where(bolsao_id: bolsao_id)
    p 'Bolsao #' + bolsao_id.to_s

    # iterate over results
    results.each do |row|
      # skip bad rows
      if !row["Nome"].present?
        p "   Skipped Applicant number ##{row["id"]} for lack of some field"
        next
      end

      # check database existance      
      next if existent_numbers.include? row["id"]

      # translate remote database's strings to local ids
      campus_id = row['Unidade']

      # create student
      std = Student.new(
        email: row["E-mail"],
        name: row["Nome"],
        # date_of_birth: row["Nascimento"],
        telephone: row["Telefone"],
        cellphone: row["Celular"]
      )
      std.save

      # create applicant
      applicant = Applicant.new(
        number: row["Inscrição"].to_i,
        # subscription_datetime: (DateTime.new(1899,12,30) + row["DataHora"].days).to_datetime,
        exam_datetime: '2013-12-01 10:00',
        exam_campus_id: campus_id,
        student_id: std.id,
        bolsao_id: bolsao_id,
        group_name: row["Disciplina"]
      )
      applicant.save
      p "   Created applicant ##{applicant.number}"
    end
  end

  def translate input
    translations = {
      'Taquara (R9)' => 'Taquara',
      '3ª Série + IME/ITA' => 'IME-ITA',
      'Madureira I' => 'Madureira I',
      'Madureira III' => 'Madureira III',
      'Vila Valqueire' => 'Valqueire',
      '3ª Série + AFA/EFOMM/EsPCEx' => 'AFA/ESPCEX',
      '3ª Série + EsPCEx' => 'ESPCEX',
      '3ª Série + Biomédicas' => 'Pré-Vestibular Biomédicas',
      '3ª Série + Pré-Vestibular' => 'Pré-Vestibular',
      '9º Ano Forte (Escolas Técnicas)' => '9º Ano Forte',
      '9º Ano Militar (Colégio Naval + EPCAr' => '9º Ano Militar',
      'AFA/EEAr/EFOMM' => 'AFA/EAAr/EFOMM',
      'AFA/EsPCEx' => 'AFA/ESPCEX',
      'AFA/EFOMM/EsPCEx' => 'AFA/ESPCEX',
      'AFA/EFOMM/ESPCEX' => 'AFA/ESPCEX',
      'Biomédicas' => 'Pré-Vestibular Biomédicas',
      'Colégio Naval + EPCAr' => '9º Ano Militar',
      '9º Ano Militar (Colégio Naval + EPCAr)' => '9º Ano Militar',
      'Pré-Vestibular' => 'Pré-Vestibular',
      'AFA / EFOMM' => 'AFA/EN/EFOMM',
      'Norte Shopping' => 'NorteShopping',
      'Tijuca I' => 'Tijuca',
      'Nova Igua' => 'Nova Iguaçu',
      'CN/EPCAR' => '9º Ano Militar',
      'Escolas Técnicas' => '9º Ano Forte',
      'EsPCEx' => 'ESPCEX',
      '1? S?rie ENEM' => '1ª Série ENEM',
      '6? Ano' => '6º Ano',
      '9? Ano Forte (Escolas T?cnicas)' => '9º Ano Forte',
      '1? S?rie ENEM' => '1ª Série ENEM',
      'Pr?-Vestibular' => 'Pré-Vestibular',
      '6? Ano' => '6º Ano',
      '9? Ano Forte (Escolas T?cnicas)' => '9º Ano Forte',
      '9? Ano Militar (Col?gio Naval + EPCAr)' => '9º Ano Militar',
      '2? S?rie ENEM' => '2ª Série ENEM',
      '3? S?rie + Pr?-Vestibular' => 'Pré-Vestibular',
      '7? Ano' => '7º Ano',
      '3? S?rie + EsPCEx' => 'ESPCEX',
      'Escolas T?cnicas' => '9º Ano Forte',
      '1? S?rie Militar' => '1ª Série Militar',
      '3? S?rie + AFA/EFOMM/EsPCEx' => 'AFA/ESPCEX',
      'Biom?dicas' => 'Pré-Vestibular Biomédicas',
      '2? S?rie Militar' => '2ª Série Militar',
      '8? Ano' => '8º Ano',
      '3? S?rie + Biom?dicas' => 'Pré-Vestibular Biomédicas',
      'Col?gio Naval + EPCAr' => '9º Ano Militar',
      'IME/ITA' => 'IME-ITA',
      # Bizarrices
      '3ª Série + Pré-Vestibular Noite' => 'Pré-Vestibular Noite',
      'Pré-Vestibular Tarde' => 'Pré-Vestibular Biomédicas',
      '3ª Série + AFA/EFOMM' => 'AFA/ESPCEX',

      '3? S?rie + IME/ITA' => 'IME-ITA',
      '9º Ano Forte (Lista de espera)' => '9º Ano Forte',
      'Pré-Vestibular Taquara Manhã (Lista de espera)' => 'Pré-Vestibular Manhã',
      '6º Ano (Fila de Espera)' => '6º Ano',
      '1ª Série ENEM (Lista de espera)' => '1ª Série ENEM',
      'AFA / ESPCEX' => 'AFA/ESPCEX',
      'S?o Gon?alo II' => 'São Gonçalo II',
      'S?o Gon?alo I' => 'São Gonçalo I',
      '07:00' => 'Manhã',
      '07:30' => 'Manhã',
      '08:00' => 'Manhã',
      '08:30' => 'Manhã',
      '09:00' => 'Manhã',
      '09:30' => 'Manhã',
      '10:00' => 'Manhã',
      '10:30' => 'Manhã',
      '11:00' => 'Manhã',
      '11:30' => 'Manhã',
      '12:00' => 'Manhã',
      '12:30' => 'Tarde',
      '13:00' => 'Tarde',
      '13:30' => 'Tarde',
      '14:00' => 'Tarde',
      '14:30' => 'Tarde',      
      '15:00' => 'Tarde',      
      '15:30' => 'Tarde',      
      '16:00' => 'Tarde',
      '1718' => '1ª Série ENEM',
      '1719' => '1ª Série Militar',
      '1720' => '2ª Série ENEM',
      '1721' => '2ª Série Militar',
      '1722' => '6º Ano',
      '1723' => '7º Ano',
      '1724' => '8º Ano',
      '1725' => '9º Ano Forte',
      '1726' => '9º Ano Militar',
      '1727' => 'AFA/ESPCEX',
      '1728' => 'Pré-Vestibular',
      '1729' => 'AFA/EEAr/EFOMM',
      '1730' => 'AFA/EN/EFOMM',
      '1731' => 'Pré-Vestibular Biomédicas',
      '1732' => 'ESPCEX',
      '1733' => 'EsSA',
      '1734' => 'IME-ITA',
      '1739' => 'AFA/ESPCEX',
      '1740' => 'IME-ITA',
      '1741' => 'ESPCEX',
      '10727' => 'Bangu',
      '10728' => 'Campo Grande II',
      '10729' => 'Madureira II',
      '10730' => 'NorteShopping',
      '10731' => 'Nova Iguaçu',
      '10733' => 'Taquara',
      '10734' => 'Tijuca',
      '10735' => 'Valqueire',
      '10736' => 'Bangu',
      '10737' => 'Campo Grande I',
      '10738' => 'Ilha do Governador',
      '10739' => 'Madureira III',
      '10740' => 'NorteShopping',
      '10741' => 'Nova Iguaçu',
      '10742' => 'Taquara',
      '10743' => 'Tijuca',
      '10744' => 'Valqueire',
      '10746' => 'Bangu',
      '10783' => 'Madureira II',
      '10748' => 'Campo Grande II',
      '10782' => 'Campo Grande II',
      '10780' => 'Valqueire',
      '10781' => 'Bangu',
      '10752' => 'Madureira II',
      '10778' => 'Taquara',
      '10779' => 'Tijuca',
      '10755' => 'NorteShopping',
      '10773' => 'Ilha do Governador',
      '10757' => 'Nova Iguaçu',
      '10775' => 'NorteShopping',
      '10776' => 'Nova Iguaçu',
      '10772' => 'Campo Grande I',
      '10770' => 'Valqueire',
      '10774' => 'Madureira I',
      '10764' => 'Taquara',
      '10771' => 'Bangu',
      '10768' => 'Tijuca',
      '10784' => 'NorteShopping',
      '10786' => 'Taquara',
      '10787' => 'Tijuca',
      '10788' => 'Valqueire',
      '10789' => 'Bangu',
      '10790' => 'Campo Grande II',
      '10791' => 'Madureira II',
      '10792' => 'NorteShopping',
      '10794' => 'Taquara',
      '10795' => 'Tijuca',
      '10796' => 'Valqueire',
      '10797' => 'Bangu',
      '10798' => 'Campo Grande II',
      '10799' => 'Madureira II',
      '10800' => 'NorteShopping',
      '10802' => 'Taquara',
      '10803' => 'Tijuca',
      '10804' => 'Valqueire',
      '10805' => 'Bangu',
      '10806' => 'Campo Grande II',
      '10807' => 'Madureira I',
      '10808' => 'NorteShopping',
      '10809' => 'Nova Iguaçu',
      '10811' => 'Taquara',
      '10812' => 'Tijuca',
      '10813' => 'Valqueire',
      '10814' => 'Bangu',
      '10815' => 'Campo Grande I',
      '10816' => 'Ilha do Governador',
      '10817' => 'Madureira III',
      '10818' => 'NorteShopping',
      '10819' => 'Nova Iguaçu',
      '10821' => 'Taquara',
      '10822' => 'Tijuca',
      '10823' => 'Valqueire',
      '10824' => 'Bangu',
      '10825' => 'Ilha do Governador',
      '10933' => 'Bangu',
      '10827' => 'NorteShopping',
      '10829' => 'Taquara',
      '10830' => 'Valqueire',
      '10831' => 'Bangu',
      '10832' => 'Campo Grande I',
      '10833' => 'Ilha do Governador',
      '10834' => 'Madureira I',
      '10835' => 'Madureira III',
      '10836' => 'NorteShopping',
      '10837' => 'Nova Iguaçu',
      '10839' => 'Taquara',
      '10840' => 'Tijuca',
      '10841' => 'Valqueire',
      '10842' => 'Campo Grande I',
      '10843' => 'Ilha do Governador',
      '10844' => 'Madureira III',
      '10845' => 'Nova Iguaçu',
      '10847' => 'Taquara',
      '10848' => 'Tijuca',
      '10849' => 'Campo Grande I',
      '10850' => 'Madureira III',
      '10851' => 'Campo Grande I',
      '10852' => 'Ilha do Governador',
      '10853' => 'Madureira I',
      '10854' => 'NorteShopping',
      '10855' => 'Nova Iguaçu',
      '10856' => 'Taquara',
      '10857' => 'Valqueire',
      '10858' => 'Tijuca',
      '10859' => 'Campo Grande I',
      '10860' => 'Madureira III',
      '10861' => 'Nova Iguaçu',
      '10862' => 'Tijuca',
      '10863' => 'Campo Grande I',
      '10864' => 'Ilha do Governador',
      '10865' => 'Madureira III',
      '10866' => 'Nova Iguaçu',
      '10868' => 'Taquara',
      '10869' => 'Tijuca',
      '10870' => 'Campo Grande I',
      '10871' => 'Madureira I',
      '10872' => 'Nova Iguaçu',
      '10873' => 'Tijuca',
      '10874' => 'Campo Grande I',
      '10879' => 'Taquara',
      '10877' => 'Taquara',
      '10880' => 'Taquara',
      '10881' => 'NorteShopping',
      '10883' => 'Campo Grande I',
      '10884' => 'Madureira III',
      '10885' => 'Campo Grande I',
      '10886' => 'Madureira III',
      '10887' => 'Madureira III',
      '10888' => 'Campo Grande I',
      '10889' => 'Ilha do Governador',
      '10890' => 'Madureira III',
      '10891' => 'Nova Iguaçu',
      '10892' => 'Madureira III',
      '10893' => 'Taquara',
      '10894' => 'Madureira III',
      '10895' => 'Madureira III',
      '10896' => 'Ilha do Governador',
      '10898' => 'Nova Iguaçu',
      '10899' => 'Taquara',
      '10900' => 'Nova Iguaçu',
      '10901' => 'Madureira III',
      '10902' => 'Madureira III',
      '10903' => 'Madureira III',
      '10904' => 'Madureira III',
      '10905' => 'Bangu',
      '10906' => 'Ilha do Governador',
      '10907' => 'NorteShopping',
      '10909' => 'Taquara',
      '10910' => 'Valqueire',
      '10911' => 'Campo Grande I',
      '10912' => 'Madureira III',
      '10914' => 'Bangu',
      '10915' => 'Campo Grande II',
      '10916' => 'Madureira I',
      '10917' => 'NorteShopping',
      '10918' => 'Nova Iguaçu',
      '10920' => 'Taquara',
      '10921' => 'Tijuca',
      '10922' => 'Valqueire',
      '10923' => 'Bangu',
      '10924' => 'Campo Grande I',
      '10925' => 'Ilha do Governador',
      '10926' => 'Madureira III',
      '10927' => 'NorteShopping',
      '10928' => 'Nova Iguaçu',
      '10930' => 'Taquara',
      '10931' => 'Tijuca',
      '10932' => 'Valqueire',
      '10934' => 'Campo Grande I',
      '10935' => 'Ilha do Governador',
      '10936' => 'Madureira I',
      '10937' => 'Madureira III',
      '10938' => 'NorteShopping',
      '10939' => 'Nova Iguaçu',
      '10941' => 'Taquara',
      '10942' => 'Tijuca',
      '10943' => 'Valqueire',
      '10944' => 'Campo Grande I',
      '10945' => 'Ilha do Governador',
      '10946' => 'Madureira I',
      '10947' => 'NorteShopping',
      '10948' => 'Nova Iguaçu',
      '10949' => 'Taquara',
      '10950' => 'Tijuca',
      '10951' => 'Valqueire',
      '10952' => 'Ilha do Governador',
      '10953' => 'Ilha do Governador',
      '10954' => 'Campo Grande I',
      '10955' => 'Ilha do Governador',
      '10956' => 'Ilha do Governador',
      '10957' => 'Ilha do Governador',
      '10958' => 'Ilha do Governador',
      '10959' => 'Ilha do Governador',
      '10960' => 'Bangu',
      '10961' => 'Madureira III',
      '10962' => 'NorteShopping',
      '10964' => 'Taquara',
      '10965' => 'Valqueire',
      '10966' => 'Campo Grande I',
      '10967' => 'Madureira III',
      '10968' => 'Nova Iguaçu',
      '10969' => 'Campo Grande I',
      '10970' => 'Madureira I',
      '10971' => 'Nova Iguaçu',
      '10972' => 'Tijuca',
      '10973' => 'Taquara',
      '10974' => 'Taquara',
      '10975' => 'Tijuca',
      '10976' => 'Bangu',
      '10977' => 'Bangu',
      '10978' => 'Bangu',
      '10979' => 'Bangu',
      'Manh' => 'Manhã'
    }
    
    if translations.keys.include? input
      translations[input]
    else
      input
    end
  end

  task select_totvs_table: :environment do
    client = TinyTds::Client.new(:username => 'temp', :password => '!@elite2012@!', :host => '200.150.153.133')

    # Retrieve list of students (currently enrolled)
    result = client.execute(
     "select
        *
      from CORPORERM.dbo.SMATRICPL as mat
      where CODTURMA = 'MADIII_2014_EsPCEx'
     "
    )

    # p 'RA,ALUNO,CODTURMA,TURMA'
    p result.fields.join(',')
    result.each do |row|
      p result.fields.map{|field| row[field]}.join(',')
      # p row.map{|key|}.join(',')
      # p [row["RA"], row["ALUNO"], row["CODTURMA"], row["TURMA"]].join(',')
    end

    client.close
  end

  task list_students: :environment do
    client = TinyTds::Client.new(:username => 'temp', :password => '!@elite2012@!', :host => '200.150.153.133')

    # Retrieve list of students (currently enrolled)
    result = client.execute(
     "select
        mat.RA, pes.NOME as ALUNO, mat.CODTURMA, tur.NOME as TURMA
      from CORPORERM.dbo.SMATRICPL as mat
        inner join CORPORERM.dbo.SALUNO as alu on alu.RA = mat.RA and alu.CODCOLIGADA = mat.CODCOLIGADA
        inner join CORPORERM.dbo.PPESSOA as pes on alu.CODPESSOA = pes.CODIGO
        inner join CORPORERM.dbo.STURMA as tur on mat.CODTURMA = tur.CODTURMA and mat.CODCOLIGADA = tur.CODCOLIGADA
      order by mat.RA"
    )

    p 'RA,ALUNO,CODTURMA,TURMA'
    result.each do |row|
      p [row["RA"], row["ALUNO"], row["CODTURMA"], row["TURMA"]].join(',')
    end

    client.close
  end

  task sync_students: :environment do
    client = TinyTds::Client.new(:username => 'temp', :password => '!@elite2012@!', :host => '200.150.153.133')

    # Retrieve list of students (currently enrolled)
    result = client.execute(
     "select
        mat.RA, pes.NOME as ALUNO, mat.CODTURMA, tur.NOME as TURMA
      from CORPORERM.dbo.SMATRICPL as mat
        inner join CORPORERM.dbo.SALUNO as alu on alu.RA = mat.RA and alu.CODCOLIGADA = mat.CODCOLIGADA
        inner join CORPORERM.dbo.PPESSOA as pes on alu.CODPESSOA = pes.CODIGO
        inner join CORPORERM.dbo.STURMA as tur on mat.CODTURMA = tur.CODTURMA and mat.CODCOLIGADA = tur.CODCOLIGADA
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