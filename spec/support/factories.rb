FactoryGirl.define do
  factory :employee do
    sequence(:elite_id) { |n| "#{n}" }
    name { "Employee#{elite_id}" }
    email { "employee#{elite_id}@sistemaeliterio.com.br" }
  end

  factory :student do
    sequence(:ra) { |n| "#{n}" }
    name { "Student#{ra}" }
    email { "student#{ra}@example.com.br" }
  end

  factory :applicant do
    student
    year
    bolsao_id '1/1/2013'
    sequence(:number) { |n| "#{n}" }
  end


  factory :campus do
    sequence(:name) { |n| "Campus#{n}" }
  end

  factory :product_type do
    sequence(:name) { |n| "ProductType#{n}" }
  end

  factory :product_group do
    sequence(:name) { |n| "ProductGroup#{n}" }
  end

  factory :product do
    product_type
    sequence(:name) { |n| "Product#{n}" }
  end

  factory :year do
    product
    year_number '2013'
    sequence(:name) { |n| "Year#{n}" }
  end

  factory :klazz do
    campus
    year
    sequence(:name) { |n| "Klazz#{n}" }
  end

  factory :klazz_type do
    sequence(:name) { |n| "KlazzType#{n}" }
  end

  factory :subject do
    sequence(:name) { |n| "Subject#{n}" }
    sequence(:short_name) { |n| "Subj#{n}" }
    sequence(:code) { |n| "Sub#{n}" }
  end

  factory :subject_thread do
    sequence(:name) { |n| "SubjectThread#{n}" }
    subject
    year
  end

  factory :teaching_assignment do
    teacher
    subject
    klazz
  end

  factory :poll do
    sequence(:name) { |n| "Poll#{n}" }
  end

  factory :exam_cycle do
    year
    sequence(:name) { |n| "ExamCycle#{n}" }
    start_date { Time.now }
    end_date { Time.now + 1.month }
  end

  factory :exam do
    sequence(:name) { |n| "Exam#{n}" }
    datetime { Time.zone.now }
    exam_cycle
    options_per_question 5
    correct_answers 'ABCDE' 
  end

  factory :exam_question do
    exam
    question
  end

  factory :question do
    sequence(:stem) { |n| "QuestionStem#{n}" }
    model_answer 'ModelAnswer'
  end

  factory :card_type do
    sequence(:name) { |n| "CardType#{n}" }
    parameters '0.4 60 540 80 40 1284 4847 1 0 7 0123456789 79 38 271 540 964 453 2 600 50 ABCDE 77 38 170 1054 473 3454'
    student_coordinates '1x2+3+4'
    command 'type_b'
    card { File.open(File.join(Rails.root, 'spec/support/card_b.tif')) }
  end

  factory :student_exam do
    card { File.open(File.join(Rails.root, 'spec/support/card_b.tif')) }
    card_processing
  end

  factory :card_processing do 
    campus_ids { create(:campus).id.to_s }
    card_type
    exam_date { Date.current }
  end

  factory :topic do
    sequence(:name) { |n| "Topic#{n}" }
    itens 'Blah blah blah'
    subject
  end
end
