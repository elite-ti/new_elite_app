# encoding: UTF-8
namespace :db do
  namespace :populate do
    namespace :real do 
      task all_periods: [:normal_periods, :contra_periods, :terceiro_ano_periods]

      ASSETS_PATH = File.join(Rails.root, 'lib/tasks/populate/real')

      DATE_DICTIONARY = {
        'Seg' => '2013-2-18',
        'Ter' => '2013-2-19',
        'Qua' => '2013-2-20',
        'Qui' => '2013-2-21',
        'Sex' => '2013-2-22',
        'Sab' => '2013-2-23'}
        
      SUBJECT_DICTIONARY = {
        'Matematica' => 'MATEMÁTICA', 
        'Biologia' => 'BIOLOGIA', 
        'Fisica' => 'FÍSICA', 
        'Geografia' => 'GEOGRAFIA', 
        'Ciencias' => 'CIÊNCIAS', 
        'Historia' => 'HISTÓRIA', 
        'Ed. Fisica' => 'EDUCAÇÃO FÍSICA', 
        'Literatura' => 'LITERATURA', 
        'Portugues' => 'LÍNGUA PORTUGUESA', 
        'Redacao' => 'REDAÇÃO', 
        'Filosofia' => 'FILOSOFIA', 
        'Sociologia' => 'SOCIOLOGIA', 
        'Ingles' => 'LÍNGUA INGLESA', 
        'Quimica' => 'QUÍMICA', 
        'Ed. Artistica' => 'EDUCAÇÃO ARTÍSTICA', 
        'Espanhol' => 'LÍNGUA ESPANHOL', 
        'sociologia' => 'SOCIOLOGIA'}

      task normal_periods: :environment do
        p 'Populating normal periods'
        ActiveRecord::Base.transaction do 
          read_csv('periods', col_sep: ';').each do |campus_name, product_name, turno, 
              klazz_sequence, klazz_name, teacher_elite_id, teacher_name, 
              subject_name, number_of_periods, week_day, position_plus_one|

            next if ['AFA/ESPCEX', 'AFA/ESPCEX CONTRA'].include? product_name
            product_name.gsub!('Regular', 'ENEM')
            product_name.gsub!('ELITE +', 'Biomédicas')
            product_name.gsub!('9º Forte', '9º Ano Forte')
            product_name.gsub!('9º Militar', '9º Ano Militar')

            create_teacher(teacher_elite_id, teacher_name) 
            create_klazz(klazz_name, product_name, campus_name)
            create_period(klazz_name, subject_name, teacher_elite_id, position_plus_one, week_day)
          end
        end
      end

      task contra_periods: :environment do 
        # * AFA/ESPCEX CONTRA ->
        #     EsPCEx
        # * AFA/ESPCEX -> 
        #     AFA/EFOMM
        #     EsPCEx
        p 'Populating contra periods'
        ActiveRecord::Base.transaction do 
          read_csv('periods', col_sep: ';').each do |campus_name, product_name, turno, 
              klazz_sequence, klazz_name, teacher_elite_id, teacher_name, 
              subject_name, number_of_periods, week_day, position_plus_one|

            next unless ['AFA/ESPCEX', 'AFA/ESPCEX CONTRA'].include? product_name
            create_teacher(teacher_elite_id, teacher_name) 

            if product_name == 'AFA/ESPCEX CONTRA'
              klazz_name = '10-1121MIL'
              campus_name = Campus.where(code: '10').first!.name
              product_name = Product.where(prefix: '11', suffix: 'MIL').first!.name
              create_klazz(klazz_name, product_name, campus_name)
              create_period(klazz_name, subject_name, teacher_elite_id, position_plus_one, week_day)
            else
              parsed_klazz_name = klazz_name.match(/(.*)-AES(.)(.)/)
              campus_code = parsed_klazz_name[1]
              turno = parsed_klazz_name[2]
              sequencial = parsed_klazz_name[3]
              campus_name = Campus.where(code: campus_code).first!.name

              %w[AFA/EFOMM ESPCEX].each do |product_name|
                product = Product.where(name: product_name).first!
                klazz_name = campus_code + '-' + product.prefix + turno + sequencial + (product.suffix || '')
                create_klazz(klazz_name, product_name, campus_name)
                create_period(klazz_name, subject_name, teacher_elite_id, position_plus_one, week_day)
              end
            end
          end
        end
      end

      task terceiro_ano_periods: :environment do 
        # TODO:
        # 3ª Série + AFA/EFOMM,Pré-Militar,3AFA,
        # 3ª Série + ESPCEX,Pré-Militar,3ESP,
        # 3ª Série + IME-ITA,Pré-Militar,3IME,
        # 3ª Série + Pré-Vestibular Biomédicas,Pré-Vestibular,3BIO,
        # 3ª Série + Pré-Vestibular Manhã,Pré-Vestibular,3PVM,
        product_names = ['AFA/EFOMM', 'ESPCEX', 'IME-ITA', 
          'Pré-Vestibular Biomédicas', 'Pré-Vestibular Manhã']
        Product.where(name: product_names).each do |product|
          product.periods.includes(klazz: :campus).each do |period|
            klazz = period.klazz
            campus = klazz.campus
            parsed_klazz_name = klazz.name.match(/#{campus.code}-#{product.prefix}(.)(.)#{product.suffix}/)
            turno = parsed_klazz_name[1]
            sequencial = parsed_klazz_name[2]

            new_product_name = '3ª Série + ' + product.name
            new_product = Product.where(name: new_product_name).first!
            new_klazz_name = "#{campus.code}-#{new_product.prefix}#{turno}#{sequencial}#{new_product.suffix}"

            new_klazz = Klazz.where(name: new_klazz_name).first_or_create!(
              product_year_id: ProductYear.where(name: new_product_name + ' - 2013').first!.id,
              campus_id: Campus.where(name: campus.name).first!.id)
            Period.create!(
              klazz_id: new_klazz.id, 
              subject_id: period.subject_id,
              teacher_id: period.teacher_id, 
              position: period.position, 
              date: period.date)
          end
        end
      end

      def create_teacher(teacher_elite_id, teacher_name)
        employee = Employee.where(elite_id: teacher_elite_id).first
        if employee.nil?
          employee = Employee.create!(
            elite_id: teacher_elite_id,
            name: teacher_name)
        end

        if employee.teacher.nil?
          Teacher.create!(
            employee_id: employee.id,
            nickname: teacher_name)
        end
      end

      def create_klazz(klazz_name, product_name, campus_name)
        Klazz.where(name: klazz_name).first_or_create!(
          product_year_id: ProductYear.where(name: product_name + ' - 2013').first!.id,
          campus_id: Campus.where(name: campus_name).first!.id)
      end

      def create_period(klazz_name, subject_name, teacher_elite_id, position_plus_one, week_day)
        Period.create!(
          klazz_id: Klazz.where(name: klazz_name).first!.id,
          subject_id: Subject.where(name: SUBJECT_DICTIONARY[subject_name]).first!.id,
          teacher_id: Employee.where(elite_id: teacher_elite_id).first!.teacher.id,
          position: position_plus_one.to_i - 1,
          date: Date.parse(DATE_DICTIONARY[week_day]))
      end
    end
  end
end
