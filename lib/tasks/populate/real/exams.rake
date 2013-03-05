# encoding: UTF-8
namespace :db do
  namespace :populate do
    namespace :real do 
      task create_afa_espcex_super_klazzes: :environment do 
        p 'Creating AFA/ESPCEX super_klazzes'
        ActiveRecord::Base.transaction do 
          [
            'Bangu',
            'Ilha do Governador',
            'NorteShopping',
            'Nova Iguaçu',
            'Taquara',
            'Valqueire',
            'São Gonçalo I'
          ].each do |campus_name|
            SuperKlazz.where(
              product_year_id: ProductYear.where(name: 'AFA/ESPCEX - 2013').first!.id,
              campus_id: Campus.where(name: campus_name).first!.id).first_or_create!
          end

          from_super_klazzes = SuperKlazz.where(
            product_year_id: ProductYear.where(name: ['ESPCEX - 2013', '3ª Série + ESPCEX - 2013']).map(&:id))
          to_super_klazzes = SuperKlazz.where(
            product_year_id: ProductYear.where(name: 'AFA/ESPCEX - 2013').first!.id)

          from_super_klazzes.each do |from_super_klazz|
            to_super_klazz = to_super_klazzes.select do |sk| sk.campus_id == from_super_klazz.campus_id end.first
            if to_super_klazz.nil?
              p from_super_klazz.campus.name
              next
            end

            from_super_klazz.enrolled_students.each do |student|
              student.enrolled_super_klazz_ids = [to_super_klazz.id]
              student.save
            end
          end
        end
      end

      task update_temporary_ras: :environment do 
        p 'Updating temporary ras'

        ActiveRecord::Base.transaction do 
          Student.where('ra > 9000000').each do |student|
            student.update_attribute :ra, student.ra - 9000000 + 8000000
          end
        end
      end

      task update_products: :environment do 
        p 'Updating products'

        ActiveRecord::Base.transaction do 
          product = Product.where(name: '3ª Série + AFA/EFOMM').first!
          product.destroy

          [
            ['3ª Série + AFA/ESPCEX', 'Pré-Militar', '3AES', '28'],
            ['3ª Série + AFA/EN/EFOMM', 'Pré-Militar', '3AEE', '29']
          ].each do |product_name, product_type_name, prefix, code|
            product = Product.create!(
              name: product_name,
              product_type_id: ProductType.where(name: product_type_name).first!.id,
              prefix: prefix,
              code: code)
            year = Year.first!
            product_year = ProductYear.create!(
              name: product_name + ' - ' + year.number.to_s, 
              product_id: product.id, 
              year_id: year.id)
            ExamCycle.where(product_year_id: product_year.id).
              first_or_create!(name: 'Ciclo 0', is_bolsao: false)
          end
        end
      end

      task add_exams_4: :environment do 
        p 'Populating exams'
        datetime = 'Sat, 02 Mar 2013 14:00:00 BRT -03:00'
        options_per_question = 5
        subject_names = ["LÍNGUA PORTUGUESA", "MATEMÁTICA"]

        ActiveRecord::Base.transaction do 
          [
            [
              ['1ª Série Militar'],
              'BDCCEBAADDABACBECADDACDCBCDACEABBBCBCBBB',
              { 'POR' => 20, 'MAT' => 20 }
            ],
            [
              ['AFA/ESPCEX', '3ª Série + AFA/ESPCEX'],
              'CEEDCBDDECCBABBCDCEACDBEAAACDACADEEDCBBD',
              { 'POR' => 10, 'MAT' => 10, 'FIS' => 10, 'ING' => 10 }
            ],
            [
              ['AFA/EN/EFOMM', '3ª Série + AFA/EN/EFOMM'],
              'CEEDCBDDECCDADBADECCCDBEAAACDACADEEDCBBD',
              { 'POR' => 10, 'MAT' => 10, 'FIS' => 10, 'ING' => 10 }
            ],
            [
              ['2ª Série Militar'],
              'EDCAABBBDCECEDEEBCEDBDCDCCEDAB',
              { 'HIS' => 10, 'GEO' => 10, 'BIO' => 10 }
            ],
            [
              ['IME-ITA', '3ª Série + IME-ITA'],
              'BEDCBDDCBB',
              { 'MAT' => 10 } # 5 questoes dissertativas
            ],
            [
              ['9º Ano Militar', 'CN/EPCAR'],
              'BDCCEBAADDADACBECADDACDCBCDACEABBBCBCBBB',
              { 'POR' => 20, 'MAT' => 20 }
            ],
            [
              ['ESPCEX', '3ª Série + ESPCEX'],
              'CEEDCBDDECADCCBCCDACCDBEAAADDACADEEDCBBD',
              { 'POR' => 10, 'MAT' => 10, 'FIS' => 10, 'ING' => 10 }
            ]
          ].each do |product_names, correct_answers, subjects_hash|
            product_names.each do |product_name|
              exam = Exam.create!(
                name: 'Ciclo 0 - P2',
                correct_answers: correct_answers,
                options_per_question: 5)

              product_year = ProductYear.where(name: product_name + ' - 2013').first!
              exam_cycle = product_year.exam_cycles.first!

              product_year.super_klazzes.each do |super_klazz|
                ExamExecution.create!(
                  exam_cycle_id: exam_cycle.id,
                  super_klazz_id: super_klazz.id,
                  exam_id: exam.id,
                  datetime: datetime)
              end

              starting_at = 1
              subjects_hash.each_pair do |subject_code, number_of_questions|
                subject = Subject.where(code: subject_code).first!

                subject_question_ids = 
                  ExamQuestion.where(
                    number: (starting_at..(starting_at + number_of_questions - 1)),
                    exam_id: exam.id).map(&:question).map(&:id)

                subject_topic = 
                  Topic.where(name: subject.name, subject_id: subject.id).
                  first_or_create!(subtopics: 'All')

                subject_question_ids.each do |subject_question_id|
                  QuestionTopic.create!(
                    question_id: subject_question_id,
                    topic_id: subject_topic.id)
                end
                starting_at = starting_at + number_of_questions
              end
            end
          end
        end
      end


      task add_exams_3: :environment do 
        p 'Populating exams 3'
        cycle_zero = 'Ciclo 0'
        start_date = 'Sat, 23 Feb 2013 00:00:00 BRT -03:00'
        end_date = 'Sat, 23 Feb 2013 23:59:00 BRT -03:00'
        datetime = 'Sat, 23 Feb 2013 14:00:00 BRT -03:00'
        options_per_question = 5
        subject_names = ["LÍNGUA PORTUGUESA", "MATEMÁTICA"]

        ActiveRecord::Base.transaction do 
          [
            [
              "Madureira III",
              "EsSA",
              "ADCEDCECACBECDAEBBCABADCAAAAECDCEBCDBDCDDBAAEDAAAD"
            ]
          ].each do |campus_name, product_name, correct_answers|
            exam = Exam.create!(
              name: cycle_zero,
              correct_answers: correct_answers,
              options_per_question: 5)

            product_year = ProductYear.where(name: product_name + ' - 2013').first!
            campus = Campus.where(name: campus_name).first!
            super_klazz = SuperKlazz.where(campus_id: campus.id, product_year_id: product_year.id).first!
            exam_cycle = product_year.exam_cycles.first!

            ExamExecution.where(
              exam_cycle_id: exam_cycle.id,
              super_klazz_id: super_klazz.id
            ).first!.update_attributes!(exam_id: exam.id)
          end
        end
      end

      task add_exams_2: :environment do 
        p 'Adding exams to third grade'
        cycle_zero = 'Ciclo 0'
        start_date = 'Sat, 23 Feb 2013 00:00:00 BRT -03:00'
        end_date = 'Sat, 23 Feb 2013 23:59:00 BRT -03:00'
        datetime = 'Sat, 23 Feb 2013 14:00:00 BRT -03:00'
        options_per_question = 5
        subject_names = ["LÍNGUA PORTUGUESA", "MATEMÁTICA"]

        correct_answers = "ACBECDAEBADCEDCECDCABCABABDCDDBAAEDAAADAAAECDCEBCD"
        product_names =  ['CN/EPCAR']

        ActiveRecord::Base.transaction do 
          exam = Exam.create!(
            name: cycle_zero,
            correct_answers: correct_answers,
            options_per_question: 5)
          product_names.each do |product_name|
            cycle_and_exam_name = cycle_zero + ' - ' + product_name
            product_year = ProductYear.where(name: product_name + ' - 2013').first!

            exam_cycle = ExamCycle.create!(
              name: cycle_and_exam_name,
              start_date: start_date,
              end_date: end_date,
              product_year_id: product_year.id,
              is_bolsao: false)

            product_year.super_klazzes.each do |super_klazz|
              ExamExecution.create!(
                exam_cycle_id: exam_cycle.id,
                super_klazz_id: super_klazz.id,
                exam_id: exam.id,
                datetime: datetime)
            end
          end
        end
      end

      task add_exams: :environment do 
        p 'Adding exams to third grade'
        cycle_zero = 'Ciclo 0'
        start_date = 'Sat, 23 Feb 2013 00:00:00 BRT -03:00'
        end_date = 'Sat, 23 Feb 2013 23:59:00 BRT -03:00'
        datetime = 'Sat, 23 Feb 2013 14:00:00 BRT -03:00'
        options_per_question = 5
        subject_names = ["LÍNGUA PORTUGUESA", "MATEMÁTICA"]

        correct_answers = "ACBECDAEBADCEDCECDCABCABAACEEACACCECDEDABDDEABBCBB"
        product_names =  ['3ª Série + ESPCEX', '3ª Série + IME-ITA']

        ActiveRecord::Base.transaction do 
          exam = Exam.create!(
            name: cycle_zero,
            correct_answers: correct_answers,
            options_per_question: 5)
          product_names.each do |product_name|
            cycle_and_exam_name = cycle_zero + ' - ' + product_name
            product_year = ProductYear.where(name: product_name + ' - 2013').first!

            exam_cycle = ExamCycle.create!(
              name: cycle_and_exam_name,
              start_date: start_date,
              end_date: end_date,
              product_year_id: product_year.id,
              is_bolsao: false)

            product_year.super_klazzes.each do |super_klazz|
              ExamExecution.create!(
                exam_cycle_id: exam_cycle.id,
                super_klazz_id: super_klazz.id,
                exam_id: exam.id,
                datetime: datetime)
            end
          end
        end
      end

      task exams: :environment do
        p 'Populating exams'
        cycle_zero = 'Ciclo 0'
        start_date = 'Sat, 23 Feb 2013 00:00:00 BRT -03:00'
        end_date = 'Sat, 23 Feb 2013 23:59:00 BRT -03:00'
        datetime = 'Sat, 23 Feb 2013 14:00:00 BRT -03:00'
        options_per_question = 5
        subject_names = ["LÍNGUA PORTUGUESA", "MATEMÁTICA"]

        ActiveRecord::Base.transaction do 
          {
            "ACBECDAEBADCEDCECDCABCABABDCDDBAAEDAAADAAAECDCEBCD" =>
              ["1ª Série Militar", "9º Ano Militar", "2ª Série Militar", "EsSA"],
            "ACBECDAEBADCEDCECDCABCABAACEEACACCECDEDABDDEABBCBB" =>
              ["AFA/EN/EFOMM", "ESPCEX", "AFA/EAAr/EFOMM", "IME-ITA", "AFA/ESPCEX"]
          }.each_pair do |correct_answers, product_names|
            exam = Exam.create!(
              name: cycle_zero,
              correct_answers: correct_answers,
              options_per_question: 5)
            product_names.each do |product_name|
              cycle_and_exam_name = cycle_zero + ' - ' + product_name
              product_year = ProductYear.where(name: product_name + ' - 2013').first!

              exam_cycle = ExamCycle.create!(
                name: cycle_and_exam_name,
                start_date: start_date,
                end_date: end_date,
                product_year_id: product_year.id,
                is_bolsao: false)

              product_year.super_klazzes.each do |super_klazz|
                ExamExecution.create!(
                  exam_cycle_id: exam_cycle.id,
                  super_klazz_id: super_klazz.id,
                  exam_id: exam.id,
                  datetime: datetime)
              end
            end
          end

          [
            [
              "Madureira III",
              "1ª Série Militar", 
              "ADCEDCECACBECDAEBCABADCABADAAAECDCEBCDBDCDDBAAEDAA"
            ],
            [
              "Madureira I",
              "2ª Série Militar",
              "CECDECDABEADCEBCAABACBACDAAAECDCEBCDBDCDDBAAEDAAAD"
            ],
            [
              "Madureira III",
              "9º Ano Militar",
              "ADCEDCECACBECDAEBBCABADCAAAAECDCEBCDBDCDDBAAEDAAAD"
            ]
          ].each do |campus_name, product_name, correct_answers|
            exam = Exam.create!(
              name: cycle_zero,
              correct_answers: correct_answers,
              options_per_question: 5)

            product_year = ProductYear.where(name: product_name + ' - 2013').first!
            campus = Campus.where(name: campus_name).first!
            super_klazz = SuperKlazz.where(campus_id: campus.id, product_year_id: product_year.id).first!
            exam_cycle = product_year.exam_cycles.first!

            ExamExecution.where(
              exam_cycle_id: exam_cycle.id,
              super_klazz_id: super_klazz.id
            ).first!.update_attributes!(exam_id: exam.id)
          end

          math = Subject.where(name: "MATEMÁTICA").first!
          math_question_ids = ExamQuestion.where(number: (26..50)).map(&:question).map(&:id)
          math_topic = Topic.create!(
            name: math.name,
            subtopics: 'All',
            subject_id: math.id)
          math_question_ids.each do |math_question_id|
            QuestionTopic.create!(
              question_id: math_question_id,
              topic_id: math_topic.id)
          end

          portuguese = Subject.where(name: "LÍNGUA PORTUGUESA").first!
          portuguese_question_ids = ExamQuestion.where(number: (1..25)).map(&:question).map(&:id)
          portuguese_topic = Topic.create!(
            name: math.name,
            subtopics: 'All',
            subject_id: portuguese.id) 
          portuguese_question_ids.each do |portuguese_question_id|
            QuestionTopic.create!(
              question_id: portuguese_question_id,
              topic_id: portuguese_topic.id)
          end
        end
      end
    end
  end
end