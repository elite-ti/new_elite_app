# encoding: utf-8
class Exam < ActiveRecord::Base  
  attr_accessible :name, :options_per_question, :correct_answers, :erp_code, :subjects, :exam_datetime, :campus_ids, :product_year_ids, :code
  attr_accessor :campus_ids, :product_year_ids

  has_many :exam_questions, dependent: :destroy, inverse_of: :exam
  has_many :questions, through: :exam_questions
  has_many :exam_executions, dependent: :destroy

  has_many :super_klazzes, through: :exam_executions, :autosave => false
  has_many :product_years, through: :super_klazzes, :autosave => false
  has_many :campuses, through: :super_klazzes, :autosave => false

  validates :name, :options_per_question, presence: true
  validate :correct_answers_range, on: :create

  
  after_create :create_questions
  before_save :update_questions, :update_subjects

  def campus_ids
    self.campuses.map(&:id)
  end

  def product_year_ids
    self.product_years.map(&:id)
  end

  def number_of_questions
    exam_questions.count
  end

  def exam_subjects
    # exam_questions.map(&:question).map(&:topics).map(&:first).map(&:subject).uniq
    exam_questions.includes(:question => {:topics => :subject}).map(&:question).map(&:topics).map(&:first).map(&:subject).uniq
  end

  def exam_full_subjects
    exam_questions.includes(:question => {:topics => :subject}).map(&:question).map(&:topics).map(&:first).map(&:subject).group_by(&:code).map{|k, v| "#{k}(#{v.size})"}.join ' + '
  end

  def exam_questions_per_subject
    exam_questions.includes(:question  => {:topics => :subject}).inject(Hash.new(0)){|h, v| h[v.topics.first.subject] += 1; h}
  end

  def exam_product_years
    exam_executions.map(&:super_klazz).map(&:product_year).uniq
  end

  def exam_campuses
    exam_executions.map(&:super_klazz).map(&:campus).uniq
  end

  def exam_dates
    exam_executions.map(&:datetime).map(&:to_date).uniq
  end

  def recalculate_grades
    correct_answers = self.correct_answers
    return if !correct_answers.present?
    number_of_questions = Hash[*self.exam_questions.map(&:question).map(&:topics).map(&:first).map(&:subject).map(&:code).group_by{|a| a}.map{|a,b| [a, b.size]}.flatten]
    subjects = self.exam_questions.map(&:question).map(&:topics).map(&:first).map(&:subject).map(&:code)
    StudentExam.where(exam_execution_id: self.exam_executions.map(&:id), status: 'Valid').each do |se|
      grades = Hash[*subjects.uniq.map{|a| [a,0]}.flatten]
      se.exam_answer_as_string.split('').each_with_index do |answer, index|
        if correct_answers[index] == 'X' || answer == correct_answers[index]
        grades[subjects[index]] = grades[subjects[index]] + 1
        end
      end
      grades.each{ |key,value| grades[key] = (10*value.to_f / number_of_questions[key].to_f).round(2) }
      se.update_column(:grades, grades.to_a.flatten.join(','))
    end    
  end

private
  def create_exam_executions ids_of_campuses, ids_of_product_years, is_bolsao=false
    product_years = ids_of_product_years.map { |e| ProductYear.find(e) }
    campuses = ids_of_campuses.map { |e| Campus.find(e) }
    cycle_name = name.split(' - ')[0]

    product_years.each do |product_year|
      exam_cycle = ExamCycle.where(
        name: cycle_name + ' - ' + product_year.product.name + " - #{subjects}").first_or_create!(
        is_bolsao: is_bolsao, product_year_id: product_year.id)

      campuses.each do |campus|
        super_klazz = SuperKlazz.where(product_year_id: product_year.id, campus_id: campus.id).first
        next if super_klazz.nil?
        
        ExamExecution.create!(
          exam_cycle_id: exam_cycle.id, 
          super_klazz_id: super_klazz.id,
          datetime: exam_datetime,
          exam_id: id,
          exam_code: code)
      end
    end    
  end

  def create_questions
    number_of_questions = self.subjects.gsub(')', '').split(' + ').map{|s| s.split('(')[1].to_i}.reduce(:+)
    (1..number_of_questions).each do |question_number|
      question = Question.create!(stem: 'Stem', model_answer: 'Model Answer')

      options_per_question.times do 
        Option.create!(question_id: question.id)
      end
      if correct_answers.present? && !correct_answers[question_number - 1].nil?
        question.options.where(letter: correct_answers[question_number - 1]).first.update_attribute :correct, true
      end

      ExamQuestion.create!(exam_id: self.id, question_id: question.id)
    end
    update_subjects
  end

  def correct_answers_range
    return if options_per_question.nil?
    return if !correct_answers.present?
    possible_letters = 'A'..('A'.ord + options_per_question - 1).chr

    correct_answers.split('').each do |answer|
      errors.add(:correct_answers, 'Resposta inválida: ' + answer) unless possible_letters.include?(answer)
    end
  end

  def update_questions
    return if exam_questions.size == 0
    return if !correct_answers.present?    
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

  def update_subjects
    return if exam_questions.size == 0
    starting_at = 1
    self.subjects.gsub(')', '').split(' + ').map{|s| s.split('(')}.each do |subject_code, number_of_questions|
      number_of_questions = number_of_questions.to_i
      subject = Subject.where(code: subject_code).first!

      subject_question_ids = 
        ExamQuestion.where(
          number: (starting_at..(starting_at + number_of_questions - 1)),
          exam_id: self.id).map(&:question).map(&:id)

      subject_topic = 
        Topic.where(name: subject.name, subject_id: subject.id).
        first_or_create!(subtopics: 'All')

      subject_question_ids.each do |subject_question_id|
        question_topic = QuestionTopic.where(question_id: subject_question_id).first_or_create!(topic_id: subject_topic.id)
        question_topic.update_column(:topic_id, subject_topic.id) if question_topic.topic_id != subject_topic.id
      end
      starting_at = starting_at + number_of_questions
    end    
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

#{errors.join("\n")}

--
EliteSim
        eos
      ).deliver    
  end

  def self.import(file, email)
    errors = []
    file = file.path if file.class.to_s != 'String'

    CSV.foreach(file, encoding:'iso-8859-1:utf-8', col_sep: ';', headers: true) do |row|
      begin
        ActiveRecord::Base.transaction do 
          is_bolsao, datetime, campus_names, product_names, exam_name, cycle_name, erp_code, subjects, correct_answers, code = row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9]

          if Exam.where(code: code).size == 1
            p "#{code} - #{product_names}"
            exam = Exam.find_by_code(code)
            exam.correct_answers = correct_answers.gsub(' ', '')
            if exam.subjects != subjects
              p 'Rebuilding questions'
              exam.exam_questions.destroy_all
              exam.subjects = subjects
              exam.create_questions
            end
            exam.save
            exam.recalculate_grades
          else
            p product_names.split('|').map{|prod| prod + ' - ' + Year.last.number.to_s}.join(', ')
            product_years = product_names.split('|').map do |p| ProductYear.where("name like '#{p + ' - ' + Year.last.number.to_s}'").first! end
            campuses = (campus_names == 'Todas' ? Campus.all : Campus.where(name: campus_names.split('|')))
            subject_hash = Hash[*subjects.gsub(')', '').split(' + ').map do |s| s.split('(') end.flatten]
            correct_answers = correct_answers.gsub(' ', '') if correct_answers.present?
            exam = Exam.create!(
              name: cycle_name + ' - ' + exam_name,
              correct_answers: correct_answers,
              options_per_question: 5,
              erp_code: erp_code,
              subjects: subjects,
              exam_datetime: Date.strptime(datetime, '%d/%m/%Y'),
              code: code)

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

        end
      rescue Exception => e
        p 'ERRO! ' + e.message 
        p e.backtrace.inspect          
        errors << [is_bolsao, datetime, campus_names, product_names, exam_name, cycle_name, subjects, correct_answers].join(', ')
      end
    end

    # send email
    # p errors
    if errors.size > 0
      send_email_importing_error(errors, email)
    else
      send_email_importing_success(email)
    end    
  end

end
