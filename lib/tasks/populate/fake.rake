# encoding: UTF-8
namespace :db do
  namespace :populate do
    namespace :fake do 

      task all: [:exams]

      task exams: :environment do
        exam_cycle_id = ExamCycle.create!(
          name: 'Ciclo 1', 
          start_date: '01/02/2013 00:00', 
          end_date: '28/02/2013 00:00', 
          product_year_id: ProductYear.where(name: '2ª Série Militar - 2013').first!.id, 
          is_bolsao: false).id

        [
          [
            {
              "datetime"=>'Fri, 01 Feb 2013 00:00:00 BRST -02:00',
              "exam_cycle_id"=>exam_cycle_id,
              "name"=>"P1",
              "correct_answers"=>"ABCDEABCDEABCDEABCDEABCDE",
              "options_per_question"=>5
            },
            []
          ],
          [
            {
              "datetime"=>'Sat, 23 Feb 2013 00:00:00 BRT -03:00',
              "exam_cycle_id"=>exam_cycle_id,
              "name"=>"Ciclo 0 - 1a Série Militar",
              "correct_answers"=>"ACBECDAEBADCEDCECDCABCABABDCDDBAAEDAAADAAAECDCEBCD",
              "options_per_question"=>5
            },
            ["LÍNGUA PORTUGUESA", "MATEMÁTICA"]
          ],
          [
            {
              "datetime"=>'Sat, 23 Feb 2013 00:00:00 BRT -03:00',
              "exam_cycle_id"=>exam_cycle_id,
              "name"=>"Cilco 0 - AFA - EN",
              "correct_answers"=>"ACBECDAEBADCEDCECDCABCABAACEEACACCECDEDABDDEABBCBB",
              "options_per_question"=>5
            },
            ["LÍNGUA PORTUGUESA", "MATEMÁTICA"]
          ],
          [
            {
              "datetime"=>'Sat, 23 Feb 2013 00:00:00 BRT -03:00',
              "exam_cycle_id"=>exam_cycle_id,
              "name"=>"Cilco 0 - AFA-ESPCEX",
              "correct_answers"=>"ACBECDAEBADCEDCECDCABCABAACEEACACCECDEDABDDEABBCBB",
              "options_per_question"=>5
            },
            ["LÍNGUA PORTUGUESA", "MATEMÁTICA"]
          ],
          [
            {
              "datetime"=>'Sat, 23 Feb 2013 00:00:00 BRT -03:00',
              "exam_cycle_id"=>exam_cycle_id,
              "name"=>"Ciclo 0 - 9° Ano Militar / CN",
              "correct_answers"=>"ACBECDAEBADCEDCECDCABCABABDCDDBAAEDAAADAAAECDCEBCD",
              "options_per_question"=>5
            },
            ["LÍNGUA PORTUGUESA", "MATEMÁTICA"]
          ],
          [
            {
              "datetime"=>'Sat, 23 Feb 2013 00:00:00 BRT -03:00',
              "exam_cycle_id"=>exam_cycle_id,
              "name"=>"Ciclo 0 - 2° Série Militar",
              "correct_answers"=>"ACBECDAEBADCEDCECDCABCABABDCDDBAAEDAAADAAAECDCEBCD",
              "options_per_question"=>5
            },
            ["LÍNGUA PORTUGUESA", "MATEMÁTICA"]
          ],
          [
            {
              "datetime"=>'Sat, 23 Feb 2013 00:00:00 BRT -03:00',
              "exam_cycle_id"=>exam_cycle_id,
              "name"=>"Ciclo 0 - EsPCEx",
              "correct_answers"=>"ACBECDAEBADCEDCECDCABCABAACEEACACCECDEDABDDEABBCBB",
              "options_per_question"=>5
            },
            ["LÍNGUA PORTUGUESA", "MATEMÁTICA"]
          ],
          [
            {
              "datetime"=>'Sat, 23 Feb 2013 00:00:00 BRT -03:00',
              "exam_cycle_id"=>exam_cycle_id,
              "name"=>"Ciclo 0 - AFA-EEAR-EFOMM",
              "correct_answers"=>"ACBECDAEBADCEDCECDCABCABAACEEACACCECDEDABDDEABBCBB",
              "options_per_question"=>5
            },
            ["LÍNGUA PORTUGUESA", "MATEMÁTICA"]
          ],
          [
            {
              "datetime"=>'Sat, 23 Feb 2013 00:00:00 BRT -03:00',
              "exam_cycle_id"=>exam_cycle_id,
              "name"=>"Ciclo 0 - EsSA",
              "correct_answers"=>"ACBECDAEBADCEDCECDCABCABABDCDDBAAEDAAADAAAECDCEBCD",
              "options_per_question"=>5
            },
            ["LÍNGUA PORTUGUESA", "MATEMÁTICA"]
          ]
        ].each do |exam_attributes, subject_names|
          exam_id = Exam.create!(exam_attributes).id
          subject_names.each do |subject_name|
            subject_id = Subject.where(name: subject_name).first!.id
            ExamSubject.create!(subject_id: subject_id, exam_id: exam_id)
          end
        end
      end
    end
  end
end


