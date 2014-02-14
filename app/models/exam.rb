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
PENSI Simulados
        eos
      ).deliver
  end

  def self.send_email_importing_error(errors, email)
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
PENSI Simulados
        eos
      ).deliver    
  end

  def self.import(file, email)
    errors = []
    file = file.path if file.class.to_s != 'String'
    CSV.foreach(file) do |is_bolsao, datetime, campus_name, product_name, exam_name, cycle_name, subjects, answers|
      begin
        ActiveRecord::Base.transaction do 
          p "#{exam_code},#{datetime},#{campus_name},#{product_name},#{exam_name},#{cycle_name},#{subjects},#{answers}"
          is_bolsao = is_bolsao == '0' ? false : true
          exam = Exam.create!(
            name: exam_name + ' - ' + product_name,
            options_per_question: 5,
            correct_answers: '',
            code: exam_code)
          campuses = campus_name == 'Todas' ? Campus.all : Campus.find_by_name(campus_name)
          exam_cycle_id = ExamCycle.where(name: cycle_name + ' - ' + product_name).first_or_create!(is_bolsao: is_bolsao, product_year_id: ProductYear.find_by_name(product_name + ' - ' + Year.first.number.to_s).id).id
          product_year_id = ProductYear.find_by_name(product_name + ' - ' + Year.first.number.to_s).id

          campuses.each do |campus|
            super_klazz_id = SuperKlazz.where(campus_id: campus.id, product_year_id: product_year_id).first.try(:id)
            next if super_klazz_id.nil?

            ExamExecution.create!(
              exam_cycle_id: exam_cycle_id,
              super_klazz_id: super_klazz_id,
              exam_id: exam.id,
              datetime: datetime.to_datetime)
          end
        end
      rescue Exception => e
        errors << [exam_code, datetime, campus_name, product_name, exam_name, cycle_name, subjects, answers].join(', ')
        p 'ERRO! ' + e.message          
      end
    end

    # send email
    if errors.size > 0
      send_email_importing_error(errors, email)
    else
      send_email_importing_success(email)
    end    
  end

end
