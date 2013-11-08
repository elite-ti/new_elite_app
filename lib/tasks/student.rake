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
      :host => "mysql.sistemaeliterio.com.br", 
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
    client = Mysql2::Client.new(
      :host => "mysql.sistemaeliterio.com.br", 
      :database => "sistemaeliteri04",
      :username => "sistemaeliteri04",
      :encoding => 'utf8',
      :password => "2elite29sistema95"
    )

    results = client.query("SELECT * FROM wp_inscricao_bolsao_2014 where bolsao = 78")

    header = []
    first = true
    # ignore = [97]
    ignored = []
    i = 1
    # focus = [97, 323, 327, 355, 388, 389, 509, 581, 767, 788, 789, 840, 946, 1010, 1152, 1182, 1239, 1267, 1273, 1299, 1307, 1437, 1447, 1461, 1462, 1480, 1578, 1658, 1708, 1724, 1736, 1759, 1768, 1778, 1793, 1817, 1847, 1890, 1964, 1976, 2008, 2066, 2114, 2133, 2184, 2248, 2289, 2475, 2478, 2494, 2644, 2671, 2686, 2726, 2809, 2856, 2944, 2947, 2948, 2949, 2950, 3081, 3090, 3192, 3195, 3202, 3231, 3240, 3392, 3406, 3556, 3712, 3713, 3735, 3767, 3770, 3771, 3908, 3971, 3989, 4007, 4091, 4140, 4144, 4149, 4223, 4235, 4239, 4249, 4255, 4263, 4268, 4275, 4284, 4303, 4304, 4316, 4317, 4336, 4337, 4354, 4357, 4374, 4375, 4382, 4397, 4403, 4415, 4431, 4454, 4460, 4501, 4502, 4513, 4530, 4536, 4539, 4542, 4559, 4562, 4572, 4581, 4583, 4587, 4588, 4594, 4595, 4631, 4660, 4664, 4697, 4704, 4705, 4715, 4735, 4757, 4779, 4785, 4787, 4802, 4835, 4836, 4840, 4841, 4844, 4869, 4870, 4883, 4885, 4886, 4897, 4907, 4913, 4926, 4951, 4955, 4959, 4974, 4975, 4983, 4984, 4987, 4988, 5048, 5050, 5059, 5060, 5067, 5082, 5086, 5114, 5155, 5158, 5164, 5186, 5193, 5198, 5206, 5263, 5265, 5284, 5293, 5304, 5309, 5329, 5336, 5339, 5348, 5350, 5358, 5360, 5368, 5399, 5400, 5404, 5423, 5431, 5487, 5522, 5527, 5534, 5543, 5582, 5583, 5632, 5654, 5660, 5663, 5696, 5699, 5701, 5703, 5725, 5729, 5782, 5784, 5794, 5818, 5819, 5824, 5837, 5873, 5886, 5888, 5895, 5931, 5934, 5941, 5944, 5951, 5952, 5955, 5957, 5964, 5965, 5974, 6026, 6049, 6055, 6057, 6061, 6076, 6077, 6083, 6087, 6099, 6108, 6115, 6121, 6125, 6128, 6151, 6178, 6179, 6193, 6194, 6196, 6202, 6206, 6248, 6250, 6270, 6272, 6273, 6280, 6285, 6311, 6322, 6357, 6373, 6383, 6393, 6398, 6400, 6402, 6403, 6429, 6452, 6455, 6463, 6465, 6473, 6474, 6490, 6505, 6508, 6509, 6517, 6518, 6526, 6529, 6532, 6534, 6535, 6543, 6544, 6556, 6571, 6576, 6583, 6590, 6594, 6623, 6627, 6634, 6637, 6642, 6643, 6644, 6645, 6673, 6737, 6768, 6769, 6784, 6794, 6808, 6821, 6832, 6839, 6842, 6844, 6894, 6900, 6919, 6929, 6932, 6940, 6948, 6952, 6966, 6971, 7002, 7019, 7030, 7037, 7058, 7067, 7080, 7084, 7089, 7094, 7095, 7112, 7119, 7120, 7138, 7140, 7144, 7157, 7169, 7171, 7177, 7205, 7222, 7233, 7248, 7283, 7284, 7304, 7313, 7348, 7353, 7364, 7384, 7409, 7419, 7448, 7449, 7514, 7515, 7529, 7531, 7566, 7573, 7583, 7586, 7632, 7637, 7641, 7657, 7659, 7662, 7687, 7710, 7733, 7745, 7752, 7756, 7757, 7761, 7775, 7782, 7790, 7803, 7834, 7841, 7852, 7860, 7862, 7874, 7884, 7901, 7908, 7909, 7910, 7911, 7914, 7940, 7967, 7978, 7993, 8019, 8031, 8057, 8061, 8073, 8077, 8091, 8115, 8124, 8125, 8153, 8168, 8171, 8173, 8196, 8201, 8207, 8215, 8225, 8232, 8233, 8237, 8243, 8245, 8255, 8272, 8289, 8290, 8304, 8314, 8318, 8325, 8329, 8396, 8403, 8412, 8450, 8463, 8471, 8475, 8485, 8520, 8524, 8530, 8563, 8564, 8584, 8585, 8590, 8656, 8661, 8682, 8693, 8706, 8715, 8718, 8745, 8772, 8793, 8812, 8821, 8837, 8838, 8879, 8886, 8893, 8925, 8959, 8960, 8977, 8989, 9018, 9026, 9029, 9053, 9066, 9067, 9071, 9075, 9095, 9097, 9118, 9121, 9150, 9152, 9170, 9182, 9204, 9216, 9229, 9264, 9267, 9288, 9309, 9323, 9327, 9337, 9341, 9349, 9402, 9430, 9432, 9524, 9547, 9554, 9573, 9577, 9579, 9604, 9634, 9643, 9655, 9657, 9679, 9698, 9701, 9702, 9704, 9721, 9729, 9730, 9733, 9747, 9748, 9785, 9789, 9803, 9807, 9832, 9839, 9857, 9871, 9883, 9893, 9899, 9904, 9913, 9923, 9930, 9958, 9982, 9991, 10023, 10025, 10032, 10040, 10049, 10079, 10087, 10089, 10098, 10103, 10106, 10110, 10111, 10143, 10145, 10149, 10153, 10156, 10190, 10198, 10206, 10215, 10227, 10231, 10234, 10240, 10289, 10302, 10305, 10306, 10314, 10325, 10334, 10342, 10348, 10349, 10358, 10377, 10404, 10409, 10410, 10411, 10417, 10436, 10445, 10448, 10454, 10456, 10461, 10475, 10485, 10494, 10497, 10506, 10518, 10522, 10531, 10540, 10545, 10550, 10551, 10554, 10555, 10557, 10560, 10562, 10564, 10575, 10597, 10598, 10599, 10600, 10602, 10609, 10630, 10631, 10634, 10635, 10687, 10690, 10713, 10727, 10745, 10756, 10764, 10767, 10781, 10783, 10784, 10796, 10832, 10842, 10850, 10859, 10868, 10877, 10903, 10920, 10952, 10981, 10982, 10985, 10993, 11004, 11010, 11035, 11042, 11055, 11058, 11066, 11089, 11092, 11110, 11113, 11121, 11132, 11138, 11153, 11156, 11167, 11169, 11179, 11180, 11186, 11188, 11199, 11206, 11217, 11220, 11234, 11280, 11284, 11301, 11305, 11320, 11333, 11337, 11339, 11341, 11347, 11353, 11358, 11361, 11362, 11373, 11378, 11399, 11402, 11428, 11437, 11439, 11452, 11481, 11502, 11507, 11508, 11513, 11530, 11565, 11572, 11581, 11591, 11609, 11616, 11644, 11654, 11657, 11671, 11672, 11686, 11687, 11702, 11727, 11728, 11765, 11778, 11781, 11784, 11787, 11791, 11817, 11819, 11820, 11823, 11839, 11843, 11847, 11848, 11850, 11857, 11858, 11862, 11869, 11913, 11921, 11934, 11979, 11999, 12004, 12007, 12020, 12023, 12031, 12044]
    focus = [97,355,1437,1724,1759,1768,1847,1890,2066,2114,2184,2289,2475,2494,2686,3231,3735,3971,4460,5265,5888,5895,6248,6473,6532,6594,7583,8091,9643,10411,11702,11817,11862]
    results.each do |row|
      # if first = true
        # applicant = Applicant.where(number: row["id"]).first_or_create
        # if applicant.id != nil
        #   p "Already found #{row["id"]}"
        #   next
        # end
        # p "Create row #{row["id"]}"
        
        # p row
        # next if ignore.include? row["id"]
        next if focus.include? row["id"]
        next if !row["nome_candidato"].present? || !row["turma"].present? || !row["unidade"].present? || !row["horario"].present?

        campus_id = Campus.where("name like '%#{translate(row['unidade'])}'").map(&:id)
        # p 'campus_id: ' + campus_id.to_s
        product_year_id = ProductYear.where("name like '#{translate(row['turma'])}%2014'").map(&:id) || -1
        # p 'product_year_id: ' + product_year_id.to_s
        sk_ids = SuperKlazz.where(product_year_id: product_year_id, campus_id: campus_id).map(&:id)
        # p 'sk_ids: ' + sk_ids.to_s
        ees = ExamExecution.where(exam_cycle_id: ExamCycle.where(is_bolsao: true).where("name like '%Bolsão 2014 -  #{translate(row['horario'])}%'").map(&:id).uniq, super_klazz_id: sk_ids || -1)
        if ees.size > 1
          ees = ees.select{|ee| ee.super_klazz.product_year.name.include? translate(row["turno"])}
        end
        bla = false
        if ees.size > 1
          # p 'Deu pau!' + translate(row["id"]).to_s + " , " + translate(row["turma"]).to_s + " , " + translate(row["unidade"]).to_s + " , " + translate(row["horario"]).to_s + " , " + i.to_s
          i += 1
          bla = true
        end
        names = ''
        names = ees.map(&:full_name).join ',' if ees.present?
        p names if bla
        # p "(#{translate(row["turma"])}, #{translate(row["unidade"])}, #{translate(row["horario"])} = #{names})" if !names.present?
        p "(#{translate(row["id"])}, #{translate(row["nome_candidato"])}, #{translate(row["turma"])}, #{translate(row["unidade"])}, #{translate(row["turno"])} = #{names})"
        # break if !names.present?
        ignored << row["id"] if !names.present?

        #   "bolsao"=>77
        #   "data_bolsao"=>Sat, 19 Oct 2013
        #   ""=>"1ª Série Militar"
        #   ""=>"Bangu"
        #   "turno"=>"Manhã"
        #   "horario"=>"10:00"
        #   "data_inscricao"=>2013-10-15 00:46:40 -0300
        std = Student.new(
          email: row["email"],
          name: row["nome_candidato"],
          cpf: row["cpf_candidato"] || row["cpf_responsavel"],
          own_cpf: row["responsavel"] == 1,
          date_of_birth: row["data_nascimento"],
          number_of_children: row["dependentes_responsavel"],
          mother_name: (row["parentesco_responsavel"] == 'Mãe' ? row["nome_responsavel"] : nil),
          father_name: (row["parentesco_responsavel"] == 'Pai' ? row["nome_responsavel"] : nil),
          telephone: row["celular_candidato"],
          cellphone: row["telefone"]
        )
        std.applied_super_klazz_ids = sk_ids
        std.save
        std.number = row["id"]
        std.save
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
      '3? S?rie + IME/ITA' => 'IME-ITA',
      '9º Ano Forte (Lista de espera)' => '9º Ano Forte',
      'Pré-Vestibular Taquara Manhã (Lista de espera)' => 'Pré-Vestibular Manhã',
      '6º Ano (Fila de Espera)' => '6º Ano',
      '1ª Série ENEM (Lista de espera)' => '1ª Série ENEM',
      'AFA / ESPCEX' => 'AFA/ESPCEX',
      'S?o Gon?alo II' => 'São Gonçalo II',
      'S?o Gon?alo I' => 'São Gonçalo I',
      '08:30' => 'Manhã',
      '09:00' => 'Manhã',
      '09:30' => 'Manhã',
      '10:00' => 'Manhã',
      '10:30' => 'Manhã',
      '13:00' => 'Tarde',
      '13:30' => 'Tarde',
      '14:00' => 'Tarde',
      '14:30' => 'Tarde',      
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