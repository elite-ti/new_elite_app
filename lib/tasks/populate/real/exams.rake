# encoding: UTF-8
namespace :db do
  namespace :populate do
    namespace :real do 
      task add_madureira_exams: :environment do 
        p 'Adding exams'
        datetime = 'Sat, 16 Mar 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'P2'
        array = [
          'U - CN/EPCAR, 9º Ano Militar - Madureira III - POR(20) + GEO(6) + HIS(6) + FIS(6) + QUI(6) + BIO(6): CDECBEAEDDCAEBEBCCDD CDBEAE BECAAB AEDCEA DAEBBD DBABCC',
          'U - 1ª Série Militar - Madureira III - POR(20) + GEO(6) + HIS(6) + FIS(6) + QUI(6) + BIO(6): CDECBEAEDDCAEBEBCCDD CDBEAE BECAAB AEDCEA EBCCEA DBABCC',
          'U - 2ª Série Militar - Madureira I - POR(10) + ING(10): BDDCEACCAD CDCDCEEDDA'] # MAT(10)
        create_exams(array, datetime, cycle_name, exam_name)
      end

      task add_missing_exam: :environment do 
        p 'Adding missing exam'
        datetime = 'Sat, 16 Mar 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'P2'
        array = [
          'C - 9º Ano Forte - All - QUI(10) + FIS(10) + HIS(10): BCBABEBBBD BDDEEDDBAB BAADBDACBB']
        create_exams(array, datetime, cycle_name, exam_name)
      end

      task add_exams: :environment do
        p 'Adding exams'
        datetime = 'Sat, 16 Mar 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'P2'
        array = [
          'C - CN/EPCAR, 9º Ano Militar - All - POR(20) + GEO(6) + HIS(6) + FIS(6) + QUI(6) + BIO(6): DDCAEBEBCCCDECBEAEDD EAECDB AABBEC CEAAED BBDDAE BCCDBA',
          'C - 1ª Série Militar - All - POR(20) + GEO(6) + HIS(6) + FIS(6) + QUI(6) + BIO(6): DDCAEBEBCCCDECBEAEDD EAECDB AABBEC CEAAED CEAEBC BCCDBA',
          'C - ESPCEX, 3ª Série + ESPCEX - All - MAT(20) + HIS(12) + GEO(12) + ING(12): DAADEBCDCCCECDECBEDC BABBBEABBBDC BACEDCBCABDB BABAEAAACCEB',
          'C - 2ª Série Militar - All - POR(10) + ING(10): DBDCEACDCA DCDCECADDE', # MAT(10)
          'C - AFA/EN/EFOMM, 3ª Série + AFA/EN/EFOMM - All - MAT(20) + FIS(20): DCCEDCCDEBEABCADCCBC ABDBDCCADEAAECEBCCDC', 
          'C - IME-ITA, 3ª Série + IME-ITA - All - QUI(10): ADABDDAAAA', # QUI(5)
          'C - AFA/ESPCEX (ESPCEX), 3ª Série + AFA/ESPCEX (ESPCEX) - All - MAT(20) + HIS(12) + GEO(12) + ING(12): DCCEDCCDEBEABCADCCBC BABBBEABBBDC BACEDCBCABDB BABAEAAACCEB',
          'C - AFA/ESPCEX (EFOMM), 3ª Série + AFA/ESPCEX (EFOMM) - All - MAT(20) + FIS(20): DCCEDCCDEBEABCADCCBC ABDBDCCADEAAECEBCCDC']
        create_exams(array, datetime, cycle_name, exam_name)
      end

      def create_exams(array, datetime, cycle_name, exam_name)
        ActiveRecord::Base.transaction do 
          array.each do |line|
            action, product_names, campus_names, exam_attributes = line.split(' - ')
            product_names = product_names.gsub(/ \(.*\)/, '')
            product_years = product_names.split(', ').map do |p| ProductYear.where(name: p + ' - 2013').first! end
            campuses = (campus_names == 'All' ? Campus.all : Campus.where(name: campus_names.split(', ')))
            subjects, correct_answers = exam_attributes.split(': ')
            subject_hash = Hash[*subjects.gsub(')', '').split(' + ').map do |s| s.split('(') end.flatten]
            correct_answers = correct_answers.gsub(' ', '')
            exam = Exam.create!(
              name: cycle_name + exam_name, 
              correct_answers: correct_answers, 
              options_per_question: 5)

            starting_at = 1
            subject_hash.each_pair do |subject_code, number_of_questions|
              number_of_questions = number_of_questions.to_i
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

            product_years.each do |product_year|
              exam_cycle = ExamCycle.where(
                name: cycle_name + product_year.name).first_or_create!(
                is_bolsao: false, product_year_id: product_year.id)

              campuses.each do |campus|
                super_klazz = SuperKlazz.where(product_year_id: product_year.id, campus_id: campus.id).first
                next if super_klazz.nil?
                
                if action == 'C'
                  ExamExecution.create!(
                    exam_cycle_id: exam_cycle.id, 
                    super_klazz_id: super_klazz.id,
                    datetime: datetime,
                    exam_id: exam.id)
                elsif action == 'U'
                  exam_execution = ExamExecution.where(exam_cycle_id: exam_cycle.id, super_klazz_id: super_klazz.id).first
                  exam_execution.update_attribute :exam_id, exam.id
                end
              end
            end
          end
        end 
      end
    end
  end
end