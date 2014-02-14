# encoding: UTF-8
class Employee < ActiveRecord::Base

  GENDERS = ['Masculino', 'Feminino']
  MARITAL_STATUSES = ['Solteiro(a)', 'Casado(a)', 'Separado(a)', 'Divorciado(a)', 'Viúvo(a)']

  mount_uploader :photo, PhotoUploader
  
  attr_accessible :elite_id, :email, :roles, :chapa,
    :name, :employee_id, :address, :suburb, :city, :state, :personal_email, 
    :identification, :expeditor, :cpf, :cellphone, :alternative_cellphone, :telephone, 
    :alternative_telephone, :contact_telephone, :contact_name, :photo, :remove_photo,
    :roles, :employee_attributes, :date_of_birth, :gender, :marital_status,
    :date_of_admission, :elite_role_id, :contract_type, :workload, 
    :cost_per_hour, :pis_pasep, :working_paper_number,
    :teacher_attributes, :product_head_teacher_attributes, 
    :campus_head_teacher_attributes, :subject_head_teacher_attributes, 
    :campus_principal_attributes, :address_attributes

  belongs_to :elite_role

  with_options dependent: :destroy do |e|
    has_one :admin
    has_one :teacher
    has_one :product_head_teacher
    has_one :campus_head_teacher
    has_one :subject_head_teacher
    has_one :campus_principal
    has_one :address, as: :addressable
  end

  with_options allow_destroy: true do |e|
    e.accepts_nested_attributes_for :teacher
    e.accepts_nested_attributes_for :product_head_teacher
    e.accepts_nested_attributes_for :campus_head_teacher
    e.accepts_nested_attributes_for :subject_head_teacher
    e.accepts_nested_attributes_for :campus_principal
    e.accepts_nested_attributes_for :address
  end

  # validates :email, uniqueness: true, allow_blank: true, 
  #   format: { with: /\A([^@\s]+)@sistemaeliterio\.com\.br\z/i }
  # validates :elite_id, presence: true, uniqueness: true
  validates :name, presence: true

  # TODO: add hr role
  ROLES = %w[admin teacher campus_head_teacher]

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def roles=(_roles)
    self.roles_mask = (_roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  ROLES.each do |role|
    define_method role + '?' do
      roles.include? role
    end
  end

  def build_roles
    (ROLES - roles).each { |role| send('build_' + role) }
  end

  def check_uid(_uid)
    if uid.nil?
      update_column :uid, _uid
    else
      logger.info "Uid from employee number #{id} changed" if _uid != uid
    end
  end

  def admin?
    roles.include? 'admin'
  end

  def remove_photo!
  end

  def self.translate_role input
    translation_hash = {
      'Admin' => 'Administrador',
      'Teacher' => 'Professor',
      'Campus head teacher' => 'Operador',
      'Campus Head Teacher' => 'Operador'
    }
    translation_hash[input] || 'Não Encontrado'
  end

  def self.send_email_importing_success(mail)
      ActionMailer::Base.mail(
        from: 'pensisim@pensi.com.br',
        to: email || 'pensisim@pensi.com.br',
        subject: "Envio arquivo importação de Usuários #{DateTime.now.strftime('%d/%m/%Y %H:%M')}",
        body: <<-eos
Olá,

Você acaba de enviar um arquivo para importação de usuários.

Não houveram problemas na importação.

--
PENSI Simulados
        eos
      ).deliver
  end

  def self.send_email_importing_error(errors, mail)
      ActionMailer::Base.mail(
        from: 'pensisim@pensi.com.br',
        to: email || 'pensisim@pensi.com.br',
        subject: "Envio arquivo importação de Usuários #{DateTime.now.strftime('%d/%m/%Y %H:%M')}",
        body: <<-eos
Olá,

Você acaba de enviar um arquivo para importação de usuários.

Os seguintes usuários tiveram problemas na importação:

#{errors.join('\n')}

--
PENSI Simulados
        eos
      ).deliver    
  end

  def self.import(file, email)
    errors = []
    file = file.path if file.class.to_s != 'String'
    CSV.foreach(file) do |name, email|
      begin
        p "#{name},#{email}"
        Employee.create!(
          name: name,
          email: email)
      rescue Exception => e
        errors << [name, email].join(', ')
        p 'ERRO! ' + e.message          
      end
    end

    # send email
    if errors.size > 0
      send_email_importing_error(errors, mail)
    else
      send_email_importing_success(email)
    end    
  end

end
