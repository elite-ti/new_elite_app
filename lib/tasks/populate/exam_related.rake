namespace :db do
  namespace :populate do
    CARD_PATH = "#{Rails.root}/spec/support/card_b.tif"
    CARD_PARAMETERS = '0.4 1 0 7 0123456789 79 38 271 540 964 453 2 600 50 ABCDE 77 38 170 1054 473 3454'
    CARD_STUDENT_COORDINATES = '1280x1000+0+0'

    task exam_related: :environment do
      p 'Creating questions'
      30.times { Question.create!(name: "Question#{Question.count}") }

      p 'Creating card type'
      CardType.create!(
        card: File.open(CARD_PATH), 
        name: 'Type B', 
        command: 'type_b',
        parameters: CARD_PARAMETERS,
        student_coordinates: CARD_STUDENT_COORDINATES 
      )

      p 'Creating exam cycles'
      exam_cycle = ExamCycle.create!(
        end_date: Time.now + 1.week, 
        name: 'Bolsao', 
        start_date: Time.now, 
        year_id: Year.first.id, 
        is_bolsao: true
      )

      p 'Creating students'
      student = Student.create!(name: 'Student1')
      Applicant.create!(
        student_id: student.id, 
        number: '1',
        bolsao_id: '1',
        year_id: exam_cycle.year.id,
      )

      student = Student.create!(name: 'Student2')
      Applicant.create!(
        student_id: student.id, 
        number: '2',
        bolsao_id: '1',
        year_id: exam_cycle.year.id,
      )

      student = Student.create!(name: 'Student3')
      Applicant.create!(
        student_id: student.id, 
        number: '3',
        bolsao_id: '1',
        year_id: exam_cycle.year.id,
      )

      student = Student.create!(name: 'Student4')
      Applicant.create!(
        student_id: student.id, 
        number: '4',
        bolsao_id: '1',
        year_id: exam_cycle.year.id,
      )

      p 'Creating exam'
      exam = Exam.create!(
        date: Time.now, 
        exam_cycle_id: ExamCycle.first.id, 
        name: 'Bolsao Fisica', 
        subject_ids: [Subject.first.id],
        question_ids: Question.all.map(&:id)
      )
    end
  end
end
