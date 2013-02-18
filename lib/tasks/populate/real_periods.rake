# encoding: UTF-8
namespace :db do
  namespace :populate do
    namespace :real do 
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
            product_name.gsub!(/Regular/, 'ENEM')
            create_teacher(teacher_elite_id, teacher_name) 
            create_klazz(klazz_name, product_name, campus_name)
            create_period(klazz_name, subject_name, teacher_elite_id, position_plus_one, week_day)
          end
        end
      end

      task contra_periods: :environment do 
        # TODO:
        # * AFA/ESPCEX -> 
        #     AFA
        #     EFOMM/EsPCEx
        # * AFA/ESPCEX CONTRA ->
        #     EFOMM/EsPCEx
      end

      task terceiro_ano_perdios: :environment do 
        # TODO:
        # 3ª Ano + AFA/EN/EFOMM,Pré-Militar
        # 3ª Ano + AFA,Pré-Militar
        # 3ª Ano + EFOMM/ESPCEX,Pré-Militar
        # 3ª Ano + ESPCEX,Pré-Militar
        # 3ª Ano + IME-ITA,Pré-Militar
        # 3ª Ano + Pré-Vestibular ELITE +,Pré-Vestibular
        # 3ª Ano + Pré-Vestibular Manhã,Pré-Vestibular 
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
          year_id: Year.where(name: product_name + ' - 2013').first!.id,
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
