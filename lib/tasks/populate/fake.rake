# encoding: UTF-8
namespace :db do
  namespace :populate do
    namespace :fake do 

      task all: [:exam_cycles, :exams, :students]

      task exam_cycles: :environment do 
        p 'Populating exam cycles'
        ExamCycle.create!(
          name: 'Ciclo 1', 
          start_date: '01/02/2013 00:00', 
          end_date: '28/02/2013 00:00', 
          product_year_id: ProductYear.where(name: '2ª Série Militar - 2013').first!.id, 
          is_bolsao: false
        )
      end

      task exams: :environment do 
        p 'Populating exams'
        Exam.create!(
          datetime: '01/02/2013 00:00', 
          exam_cycle_id: ExamCycle.first.id, 
          name: 'P1',
          correct_answers: 'ABCDEABCDEABCDEABCDEABCDEABCDE',
          options_per_question: 5)
      end

      task students: :environment do 
        ActiveRecord::Base.transaction do 
          p 'Populating students'
          [
            {"name"=>"Student", "ra"=>"0"},
            {"name"=>"Teste", "ra"=>"246864"},
            {"name"=>"Aleixa Carvalho", "ra"=>"0046544"},
            {"name"=>"Isabelle Carvalho", "ra"=>"0046482"},
            {"name"=>"Isis Alanis C. Cordeiro", "ra"=>"1001013"},
            {"name"=>"Joao Victor Tavares", "ra"=>"0046546"},
            {"name"=>"Mateus Damasceno", "ra"=>"0047034"},
            {"name"=>"Tatiana Machado", "ra"=>"0047381"},
            {"name"=>"Thamiris da Silva", "ra"=>"0047434"},
            {"name"=>"Juliana Bravin", "ra"=>"0047188"}
          ].each do |student_attributes|
            Student.create!(student_attributes)
          end
          [
            ["0", "01-1221MIL"], 
            ["246864", "01-1221MIL"], 
            ["0046544", "01-1221MIL"], 
            ["0046482", "01-1222MIL"], 
            ["1001013", "01-1221MIL"], 
            ["0046546", "01-1221MIL"], 
            ["0047034", "01-1221MIL"], 
            ["0047381", "01-1221MIL"], 
            ["0047434", "01-1221MIL"], 
            ["0047188", "01-1221MIL"]
          ].each do |ra, klazz_name|
            klazz_id = Klazz.where(name: klazz_name).first!.id
            student_id = Student.where(ra: ra.to_i).first!.id
            Enrollment.create(klazz_id: klazz_id, student_id: student_id)
          end
          [
            ["0046482",
            {"street"=>"Estrada do Bananal, 535. Bl: 01, Ap: 606",
             "suburb"=>"Freguesia",
             "city"=>"Rio de Janeiro ",
             "state"=>"RJ"}],
            ["1001013",
            {"street"=>"Rua Visconde de Santa Isabel, 265",
             "suburb"=>"Vila Isabel",
             "city"=>"Rio de Janeiro ",
             "state"=>"RJ"}],
            ["0046546",
            {"street"=>"Rua dos Artistas,204 Ap: 401",
             "suburb"=>"Vila Isabel",
             "city"=>"Rio de Janeiro "}],
            ["0047381",
            {"street"=>"Rua Bolívar, 164",
             "suburb"=>"Copacabana",
             "city"=>"Rio de Janeiro "}],
            ["0047434",
            {"street"=>"Rua Otávio Mangabeira, 331",
             "suburb"=>"Jardim América",
             "city"=>"Rio de Janeiro ",
             "state"=>"RJ"}]
          ].each do |ra, address_attributes|
            student = Student.where(ra: ra.to_i).first!
            student.update_attributes(address_attributes: address_attributes)
          end
        end
      end
    end
  end
end



