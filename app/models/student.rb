#encoding: utf-8

class Student < ActiveRecord::Base
  
  attr_accessible :email, :name, :password_digest, :ra, :gender,
    :cpf, :own_cpf, :rg, :rg_expeditor, :date_of_birth, :number_of_children, 
    :mother_name, :father_name, :telephone, :cellphone, :previous_school,
    :address_attributes, :applied_super_klazz_ids, :number, :enrolled_klazz_ids
    # , :enrolled_super_klazz_ids

  has_many :enrollments, dependent: :destroy, inverse_of: :student
  has_many :enrolled_super_klazzes, through: :enrollments, source: :super_klazz
  has_many :enrolled_klazzes, through: :enrollments, source: :klazz
  has_many :enrolled_exam_executions, through: :enrolled_super_klazzes, source: :exam_executions
  has_many :enrolled_exams, through: :enrolled_exam_executions, source: :exam

  has_many :applicants, dependent: :destroy, inverse_of: :student
  has_many :applied_super_klazzes, through: :applicants, source: :super_klazz
  has_many :applied_exam_executions, through: :applied_super_klazzes, source: :exam_executions
  has_many :applied_exams, through: :applied_exam_cycles, source: :exam

  has_many :student_exams, dependent: :destroy
  has_many :exams, through: :student_exams

  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address

  validates :name, presence: true
  validates :ra, uniqueness: true, allow_blank: true

  def possible_exam_executions(is_bolsao, exam_date)
    (is_bolsao ? applied_exam_executions : enrolled_exam_executions).
      where(datetime: (exam_date.beginning_of_day)..(exam_date.end_of_day))
  end

  def number
    applicants.map{|ap| ap.try(:number) || ''}.try(:first)
  end

  def number= value
    applicants.each do |applicant|
      applicant.number = value
      applicant.save
    end
  end

  def calculate_temporary_number(super_klazz_id, variable_digits)
    super_klazz = SuperKlazz.find(super_klazz_id)
    min_temporary_ra = '9' + super_klazz.campus.code + super_klazz.product_year.product.code + ('0' * variable_digits)
    min_temporary_ra = min_temporary_ra.to_i - 1
    max_ra = super_klazz.enrolled_students.maximum(:ra)
    ra = 0
    if max_ra.nil?
      ra = min_temporary_ra.to_i
    else
      ra = [max_ra, min_temporary_ra.to_i].max
    end
    ra = ra + 1
    p '============ ' + ra.to_s
    while Applicant.where(number: ra).size > 0
      ra = ra + 1  
    end
    ra
  end

  def self.calculate_temporary_ra(super_klazz_id, variable_digits)
    super_klazz = SuperKlazz.find(super_klazz_id)
    min_temporary_ra = '9' + super_klazz.campus.code + super_klazz.product_year.product.code + ('0' * variable_digits)
    min_temporary_ra = min_temporary_ra.to_i - 1
    max_ra = super_klazz.enrolled_students.maximum(:ra)
    ra = 0
    if max_ra.nil?
      ra = min_temporary_ra.to_i
    else
      ra = [max_ra, min_temporary_ra.to_i].max
    end
    ra = ra + 1
    while Student.where(ra: ra).size > 0
      ra = ra + 1  
    end
    ra
  end

  def self.create_temporary_student!(name, super_klazz_id)
    student = Student.new
    student.name = name
    student.ra = calculate_temporary_ra(super_klazz_id, 2)
    student.enrolled_super_klazz_ids = [super_klazz_id]
    student.save!
    student
  end

  def fix_temporary_student(new_ra)
    if Student.find_by_ra(new_ra.to_i).nil?
      self.ra = new_ra.to_i
      self.save
      return
    end
    new_id = Student.find_by_ra(new_ra.to_i).id
    # Change student exams
    Student.find_by_ra(self.ra).student_exams.each do |se|
      log_changes 'Mudando StudentExam #' + se.id.to_s + ' de ' + se.student_id.to_s + ' para ' + new_id.to_s
      se.update_column(:student_id, new_id)
    end
    # Change enrollments
    Student.find_by_ra(self.ra).enrollments.each do |enr|
      log_changes "Mudando enrollments id #{enr.id.to_s} (sk: #{enr.super_klazz_id.to_s}) de #{enr.student_id.to_s} para #{new_id.to_s}"
      if Student.find_by_ra(new_ra.to_i).enrollments.map(&:super_klazz_id).include? enr.super_klazz_id
        enr.destroy
      else
        enr.update_column(:student_id, new_id)
      end
    end
    if self.enrollments.size == 0 && self.student_exams.size == 0
      self.destroy
    end
  end

  def self.send_email_importing_success(email)
      ActionMailer::Base.mail(
        from: 'pensisim@pensi.com.br',
        to: email || 'pensisim@pensi.com.br',
        subject: "Envio arquivo importação de Alunos #{DateTime.now.strftime('%d/%m/%Y %H:%M')}",
        body: <<-eos
Olá,

Você acaba de enviar um arquivo para importação de alunos.

Não houveram problemas na importação.

--
PENSI Simulados
        eos
      ).deliver
  end

  def self.send_email_importing_error(errors, email)
      ActionMailer::Base.mail(
        from: 'pensisim@pensi.com.br',
        to: email || 'pensisim@pensi.com.br',
        subject: "Envio arquivo importação de Alunos #{DateTime.now.strftime('%d/%m/%Y %H:%M')}",
        body: <<-eos
Olá,

Você acaba de enviar um arquivo para importação de alunos.

Os seguintes alunos tiveram problemas na importação:

#{errors.join('\n')}

--
PENSI Simulados
        eos
      ).deliver    
  end

  def self.import(file, email)
    errors = []
    file = file.path if file.class.to_s != 'String'
    CSV.foreach(file, encoding:'iso-8859-1:utf-8', col_sep: ';') do |ra, student_name, campus_name, product_name, klazz_name|
      begin
        p "#{ra},#{student_name},#{campus_name},#{product_name},#{klazz_name}"
        student = Student.where(ra: ra.to_i).first_or_create!(name: student_name)
        Enrollment.where(
          student_id: student.id, 
          super_klazz_id: SuperKlazz.where(campus_id: Campus.find_by_name(campus_name).id, product_year_id: ProductYear.find_by_name(product_name + ' - ' + Year.first.number.to_s).id).first.id,
          klazz_id: Klazz.find_by_name("#{campus_name} - #{klazz_name}").try(:id)).first_or_create!
      rescue Exception => e
        errors << [ra, student_name, campus_name, product_name, klazz_name].join(', ')
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

  def log_changes(message)
    File.open("log.txt", "a"){ |somefile| somefile.puts message }
  end

end
