# encoding: utf-8
class Exam < ActiveRecord::Base  
  attr_accessible :name, :options_per_question, :correct_answers

  has_many :exam_questions, dependent: :destroy, inverse_of: :exam
  has_many :questions, through: :exam_questions
  has_many :mini_exams, dependent: :destroy
  has_many :exam_executions, dependent: :destroy

  validates :name, :correct_answers, :options_per_question, presence: true
  validate :correct_answers_range, on: :create

  after_create :create_questions
  before_save :update_questions

  def number_of_questions
    exam_questions.count
  end

  def exam_subjects
    # exam_questions.map(&:question).map(&:topics).map(&:first).map(&:subject).uniq
    exam_questions.includes(:question => {:topics => :subject}).map(&:question).map(&:topics).map(&:first).map(&:subject).uniq
  end

  def exam_questions_per_subject
    exam_questions.includes(:question  => {:topics => :subject}).inject(Hash.new(0)){|h, v| h[v.topics.first.subject] += 1; h}
  end

  def exam_product_years
    exam_executions.map(&:super_klazz).map(&:product_year).uniq
  end

  def exam_dates
    exam_executions.map(&:datetime).map(&:to_date).uniq
  end

private

  def correct_answers_range
    return if options_per_question.nil?
    # TODO: refactor
    initial_letter, final_letter = 'A', 'A'
    options_per_question.times { final_letter.next! }
    possible_letters = initial_letter..final_letter

    correct_answers.split('').each do |answer|
      unless possible_letters.include?(answer) 
        errors.add(:correct_answers, 'invalid answer: ' + answer)
      end
    end
  end

  def update_questions
    return if exam_questions.size == 0
    self.correct_answers.split('').each_with_index do |correct_letter, i|
      question_options = self.exam_questions.where(number: i+1).first.question.options
      question_options.each {|o| o.update_column(:correct, false)}
      if correct_letter == 'X'
        question_options.each{|option| option.update_column(:correct, true)}
      else
        question_options.select{|o| o.letter == correct_letter}.first.update_column(:correct, true)
      end
    end
  end

  def create_questions
    # correct_answers_with_subjects = Hash[*subject_id.zip(correct_answers).flatten]
    # correct_answers_with_subjects.each do |code, answer|
    correct_answers.split('').each do |answer|
      question = Question.create!(stem: 'Stem', model_answer: 'Model Answer')

      options_per_question.times do 
        Option.create!(question_id: question.id)
      end
      question.options.where(letter: answer).first.update_attribute :correct, true

      ExamQuestion.create!(exam_id: self.id, question_id: question.id)
    end
  end

  def get_correct_answers
    exam_questions.sort{|x, y| x.number <=> y.number}.map(&:question).flatten.map{|q| q.correct_options.map(&:letter).join()}
  end  

  def self.send_email_importing_success(email)
      ActionMailer::Base.mail(
        from: 'elitesim@sistemaeliterio.com.br',
        to: email || 'elitesim@sistemaeliterio.com.br',
        subject: "Envio arquivo importação de Provas #{DateTime.now.strftime('%d/%m/%Y %H:%M')}",
        body: <<-eos
Olá,

Você acaba de enviar um arquivo para importação de provas.

Não houveram problemas na importação.

--
EliteSim
        eos
      ).deliver
  end

  def self.send_email_importing_error(errors, email)
    # test
      ActionMailer::Base.mail(
        from: 'elitesim@sistemaeliterio.com.br',
        to: email || 'elitesim@sistemaeliterio.com.br',
        subject: "Envio arquivo importação de Provas #{DateTime.now.strftime('%d/%m/%Y %H:%M')}",
        body: <<-eos
Olá,

Você acaba de enviar um arquivo para importação de provas.

As seguintes provas tiveram problemas na importação:

#{errors.join('\n')}

--
EliteSim
        eos
      ).deliver    
  end

  def self.import(file, email)
    errors = []
    file = file.path if file.class.to_s != 'String'

    CSV.foreach(file) do |is_bolsao, datetime, campus_names, product_names, exam_name, cycle_name, subjects, correct_answers|
      begin
        ActiveRecord::Base.transaction do 
          p "#{is_bolsao},#{datetime},#{campus_names},#{product_names},#{exam_name},#{cycle_name},#{subjects},#{correct_answers}"

          p product_names.split('|').map{|prod| prod + ' - ' + Year.last.number.to_s}.join(', ')
          product_years = product_names.split('|').map do |p| ProductYear.where(name: p + ' - ' + Year.last.number.to_s).first! end
          campuses = (campus_names == 'Todas' ? Campus.all : Campus.where(name: campus_names.split('|')))
          subject_hash = Hash[*subjects.gsub(')', '').split(' + ').map do |s| s.split('(') end.flatten]
          correct_answers = correct_answers.gsub(' ', '')
          exam = Exam.create!(
            name: cycle_name + ' - ' + exam_name, 
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
              name: cycle_name + ' - ' + product_year.product.name + " - #{subjects}").first_or_create!(
              is_bolsao: is_bolsao == 'S', product_year_id: product_year.id)

            campuses.each do |campus|
              super_klazz = SuperKlazz.where(product_year_id: product_year.id, campus_id: campus.id).first
              next if super_klazz.nil?
              
              ExamExecution.create!(
                exam_cycle_id: exam_cycle.id, 
                super_klazz_id: super_klazz.id,
                datetime: datetime,
                exam_id: exam.id)
            end
          end

        end
      rescue Exception => e
        errors << [is_bolsao, datetime, campus_names, product_names, exam_name, cycle_name, subjects, correct_answers].join(', ')
        p 'ERRO! ' + e.message          
      end
    end

    # send email
    p errors
    if errors.size > 0
      send_email_importing_error(errors, email)
    else
      send_email_importing_success(email)
    end    
  end

end
