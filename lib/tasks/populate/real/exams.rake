# encoding: UTF-8
namespace :db do
  namespace :populate do
    namespace :real do 
      task exams: :environment do
        p 'Populating exams'
        partial_cycle_name = 'Ciclo 0 - '
        start_date = 'Sat, 23 Feb 2013 00:00:00 BRT -03:00'
        end_date = 'Sat, 23 Feb 2013 23:59:00 BRT -03:00'
        datetime = 'Sat, 23 Feb 2013 14:00:00 BRT -03:00'
        options_per_question = 5
        subject_names = ["LÍNGUA PORTUGUESA", "MATEMÁTICA"]

        ActiveRecord::Base.transaction do 
          [
            [
              "1ª Série Militar",
              "ACBECDAEBADCEDCECDCABCABABDCDDBAAEDAAADAAAECDCEBCD"
            ],
            [
              "AFA/EN/EFOMM",
              "ACBECDAEBADCEDCECDCABCABAACEEACACCECDEDABDDEABBCBB"
            ],
            [
              "9º Ano Militar",
              "ACBECDAEBADCEDCECDCABCABABDCDDBAAEDAAADAAAECDCEBCD"
            ],
            [
              "2ª Série Militar",
              "ACBECDAEBADCEDCECDCABCABABDCDDBAAEDAAADAAAECDCEBCD"
            ],
            [
              "ESPCEX",
              "ACBECDAEBADCEDCECDCABCABAACEEACACCECDEDABDDEABBCBB"
            ],
            [
              "AFA/EAAr/EFOMM",
              "ACBECDAEBADCEDCECDCABCABAACEEACACCECDEDABDDEABBCBB"
            ],
            [
              "EsSA",
              "ACBECDAEBADCEDCECDCABCABABDCDDBAAEDAAADAAAECDCEBCD"
            ]
          ].each do |product_name, correct_answers|
            cycle_and_exam_name = partial_cycle_name + product_name
            exam_cycle = ExamCycle.create!(
              name: cycle_and_exam_name,
              start_date: start_date,
              end_date: end_date,
              product_year_id: ProductYear.where(name: product_name + ' - 2013').first!.id,
              is_bolsao: false)
            Exam.create!(
              exam_cycle_id: exam_cycle.id,
              subject_ids: subject_names.map { |subject_name| Subject.where(name: subject_name).first!.id },
              datetime: datetime,
              name: cycle_and_exam_name,
              correct_answers: correct_answers,
              options_per_question: 5)
          end
        end
      end
    end
  end
end


