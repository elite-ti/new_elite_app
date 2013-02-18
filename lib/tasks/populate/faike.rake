namespace :db do
  namespace :populate do
    namespace :faike do 
      CARD_PATH = "#{Rails.root}/spec/support/card_b.tif"
      CARD_PARAMETERS = '0.4 60 540 80 40 1284 4847 1 0 7 0123456789 79 38 271 540 964 453 2 600 50 ABCDE 77 38 170 1054 473 3454'
      CARD_STUDENT_COORDINATES = '1280x1000+0+0'

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
          year_id: Year.first.id, 
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
            year_id: ExamCycle.first.year.id,
          )
        end
      end

      task exams: :environment do 
        # p 'Populating exam'
        # ActiveRecord::Base.transaction do 
        #   exam = Exam.create!(
        #     datetime: Time.zone.now, 
        #     exam_cycle_id: ExamCycle.first.id, 
        #     name: 'Bolsao Fisica',
        #     correct_answers: '',
        #     options_per_
        #   )
        #   Question.limit(30).all.each do |question|
        #     ExamQuestion.create(
        #       question_id: question.id,
        #       exam_id: exam.id)
        #   end
        # end
      end
    end
  end
end
