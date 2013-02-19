namespace :db do
  namespace :populate do
    namespace :fake do 

      task all: [:topics_and_questions, :card_types, :exam_cycles, :applicants, :exams]

      task topics_and_questions: :environment do
        p 'Populating topics and questions'
        Subject.all.each do |subject|
          10.times do |i|
            topic = Topic.create!(
              name: "#{subject.name} Topic #{i}",
              subject_id: subject.id,
              itens: "Various itens"
            )
            Question.create!(
              stem: "#{subject.name} Question #{i}", 
              model_answer: 'ModelAnswer',
              topic_ids: [topic.id]
            ) 
          end
        end
      end

      task card_types: :environment do 
        p 'Populating card types'
        CardType.create!(
          card: File.open(CARD_PATH), 
          name: 'Type B', 
          command: 'type_b',
          parameters: CARD_PARAMETERS,
          student_coordinates: CARD_STUDENT_COORDINATES 
        )
      end

      task exam_cycles: :environment do 
        p 'Populating exam cycles'
        ExamCycle.create!(
          end_date: Time.now + 1.week, 
          name: 'Bolsao', 
          start_date: Time.now, 
          product_year_id: ProductYear.first.id, 
          is_bolsao: true
        )
      end

      task applicants: :environment do 
        p 'Populating applicants'
        10.times do |i|
          student = Student.create!(name: "Student #{i}")
          Applicant.create!(
            student_id: student.id, 
            number: "#{i}",
            bolsao_id: '1',
            product_year_id: ExamCycle.first.product_year.id,
          )
        end
      end

      task exams: :environment do 
        p 'Populating exams'
        ActiveRecord::Base.transaction do 
          Exam.create!(
            datetime: Time.zone.now, 
            exam_cycle_id: ExamCycle.first.id, 
            name: 'Bolsao Fisica',
            correct_answers: 'ABCDEABCDEABCDEABCDEABCDEABCDE',
            options_per_question: 5)
        end
      end
    end
  end
end
