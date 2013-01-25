namespace :db do
  namespace :populate do
    CARD_PATH = "#{Rails.root}/spec/support/card_b.tif"
    CARD_PARAMETERS = '0.4 2 1 0 7 0123456789 80 43 281 914 969 528 2 600 50 ABCDE 88 43 183 1050 495 3471'

    task answer_card_type: :environment do
      AnswerCardType.create(
        card: File.open(CARD_PATH), 
        name: 'Type B', 
        parameters: CARD_PARAMETERS, 
        student_number_length: 7,
      )
    end

    task exam_cycle: :environment do
      ExamCycle.create(
        end_date: Time.now + 1.week, 
        name: 'Bolsao', 
        start_date: Time.now, 
        year_id: Year.first.id, 
        is_bolsao: true
      )
    end

    task questions: :environment do
      35.times { Question.create(name: "Question#{Question.count}") }
    end

    task exam: :environment do
      exam = Exam.create(
        date: Time.now, 
        exam_cycle_id: ExamCycle.first.id, 
        name: 'Bolsao Fisica', 
        subject_ids: [Subject.first.id],
        question_ids: Question.all.map(&:id)
      )
    end
  end
end
