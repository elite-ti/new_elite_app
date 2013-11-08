# encoding: UTF-8

namespace :student do
  task create_attendance_lists: :environment do
    `mkdir #{File.join(Rails.root,'public/lists')}`  if !File.exists?(File.join(Rails.root,'public/lists'))
    ExamCycle.where(is_bolsao: true).map(&:exam_executions).flatten.uniq.each do |exam_execution|
      p exam_execution.full_name
      pdf = AttendanceListPrawn.new(exam_execution.id)
      filename = File.join(Rails.root,'public/lists', 'ListaPresença - ' + exam_execution.full_name.split('-')[3].strip + ' - ' + exam_execution.super_klazz.campus.name + ' - ' + exam_execution.super_klazz.product_year.product.name.gsub(/\//,'-') + '.pdf')
      pdf.render_file(filename)
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

    results = client.query("SELECT * from wp_inscricao_bolsao_2014 where bolsao = 78")
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
    results = client.query("SELECT * FROM wp_inscricao_bolsao_2014 where bolsao = 78")

    # run query to get all applicants
    p 'Running query:'
    p "SELECT * FROM wp_inscricao_bolsao_2014 where bolsao = #{bolsao_id}"
    results = client.query("SELECT * FROM wp_inscricao_bolsao_2014 where bolsao = #{bolsao_id}")

    # iterate over results
    ignored = []
    to_ignore = [15077,18865,19450,15990,18741,19026,17934,14547,15145,19157,19158,19379,18367,16592,19164,19168,19170,14917,14008,18884,18934,19288,14819,19480,19117,19118,19264,17456,20474,15565,15571,19471,19472,19473,18913,18916,17359,13732,14560,19478,19010,19260,19271,19829,19207,19318,18995,14263,17804,19382,20042,14396,16288,19194,13766,18736,17256,17388,19684,16880,18907,18911,19417,18993,18998,19535,18242,19315,19191,19193,12976,16374,15134,19750,15554,14692,19326,15060,19422,13601,14010,19361,20097,19167,18899,13226,20247,18553,14172,12656,16283,19341,17193,14520,19925,18419,19333,18522,18506,19283,19284,19285,17323,14715,17217,17220,19399,19400,13713,13744,13541,14348,19270,19023,14683,19250,18028,20317,14254,12647,14769,19064,19065,19294,19751,19621,17234,15351,15220,16023,16024,19971,16696,19261,12748,19741,18450,19373,19374,19496,19452,20381,19330,18366,19245,19726,18573,19145,14509,14512,19140,19141,12820,19196,12731,19441,18142,20090,20051,15393,16890,18793,19387,17307,14550,19821,15633,19499,16094,18893,19227,19228,18097,18610,17336,15934,19020,20178,19068,16059,18151,19717,19200,19201,19784,14165,16388,17549,18514,13118,19965,16638,14922,16826,12659,19101,19520,19578,18967,17377,20013,16036,19376,18531,14047,18585,13708,18637,13100,19446,19500,19503,16807,14031,14035,18886,17951,15845,14707,13079,14762,14909,16132,18751,18973,12842,13099,19436,17867,18042,15957,14542,18439,14974,15398,14036,17746,19070,19071,19694,19189,15916,19792,15159,17066,13409,17674,19124,19385,19386,19280,13375,13379,19810,13370,13371,17380,17381,19402,19403,19404,19173,19108,16223,18985,19688,14079,18823,18982,12582,13958,12913,18936,19133,19363,19364,19136,19137,13739,19322,19332,14768,14821,20137,15404,16228,14066,18571,19186,12949,13672,14881,13447,12721,13663,18607,18231,15445,13641,18957,13574,18547,12966,19348,19349,19350,16803,19433,12974,14369,13901,19439,14446,18925,19456,19085,20219,14395,19481,19425,19426,19243,13116,15275,18105,18332,18510,19049,16941,19312,14074,15266,15375,19537,14867,18158,18947,19411,18334,13254,18929,18930,18931,18933,14498,19154,14002,15566,17830,19300,19301,13194,19832,19246,18940,19066,18429,19572,15259,14966,15515,19258,15678,13007,18246,12728,13289,19061,19062,12684,18915,17210,19335,19920,15860,18716,14489,19125,19126,19001,19805,19305,17517,18402,19462,19464,19465,19467,19468,19303,18820,19161,19165,20249,19392,19225,17944,14181,18355,19909,20423,14938,15171,13973,17052,15611,13197,19292,18882,12553,13111,14287,19248,13050,16964,16681,16217,19566,18025,18989,18990,19337,17562,12954,19278,18909,18910,12900,19484,19485,14399,12905,14926,14929,14143,18953,18954,18955,18959,19106,19003,17252,19096,19097,19098,15913,19820,20115,15634,19353,19059,19060,18665,12641,19575,19328,19338,19340,19130,19008,18890,19676,19406,18743,19735,18951,18962,18963,15930,13499,18822,16949,19526,16022,19297,19817,13261,19347,19355,19357,19358,19359,16514,14449,19953,12931,19178,19366,19831,14195,19368,19369,19138,19494,16751,13621,15600,19586,18918,18949,17147,19641,12766,13890,18183,13940,15070,18692,19459,19219,19220,15106,17687,20264,14384,13608,18011,15414,19877,19090,19521,13199,12740,12890,19043,19044,14999,19939,14445,19028,19031,14534,14545,15639,12840,18901,13024,19033,17802,19448,15345,19095,19159,19488,14740,13337,19232,20117,14435,18997,18944,16824,18771,18974,18975,18976,18977,18978,18667,18198,19712,18981,19482,18617,12695,12806,13613,13635,20125,15823,19744,12681,14815,19959,20069,19004,19005,19006,19089,19180,18922,18677,13190,13193,19740,15416,19395,19397,19514,18393,19236,19238,19639,19109,19605,18239,13055,18908,18055,18939,19080,19081,19082,19091,19603,13877,13684,15902,14897,20459,20120,13550,17398,19840,19223,18066,18357,19569,19088,20058,19409,18579,14249,14081,18969,18970,16734,19299,19979,19475,14116,19501,14417,15568,20114,16849,14260,19558,15815,12771,18988,19476,16272,19442,13362,20359,12657,17472,15518,19687,17527,14102,14632,15466,19112,20344,15850,19012,19454,19054,19055,15506,13950,13345,19615,19203,19046,19047,19343,19344,19346,19908,15742,19265,19266,19267,19268,19272,19429,19430,16904,18802,14634,14714,14325,18521,13911,14824,14831,18276,19645,20355,19290,18905,18906,15630,19218,19221,17326,1113,16259,18411]      
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
        break if sk_ids.size != 1
        p '   Managed it!'
      elsif sk_ids.size > 1
        p '   Found more than one klazz for him: ' + sk_ids.map{|id| SuperKlazz.find(id).name}.join(',')
        p row
        break
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