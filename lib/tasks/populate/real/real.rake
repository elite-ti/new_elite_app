namespace :db do
  namespace :populate do
    namespace :real do 
      # Set this path to where you saved teachers photos
      PHOTOS_PATH = ''
      ASSETS_PATH = File.join(Rails.root, 'lib/tasks/populate/real/csvs')
      
      CARD_PATH = "#{Rails.root}/spec/support/card_b.tif"
      CARD_PARAMETERS = '0.4 60 540 80 40 1284 4847 1 0 7 0123456789 79 38 271 540 964 453 2 600 50 ABCDE 77 38 170 1054 473 3454'
      CARD_STUDENT_COORDINATES = '1280x1000+0+0'

      task quick: [
        :product_types, :product_groups, :products, :years, :product_years, :campuses, 
        :subjects, :klazz_types, :majors, :school_roles, 
        :elite_roles, :absence_reasons, :employees, :teachers, :admins, 
        :poll_question_types, :poll_question_categories, :card_types, :campus_head_teachers]

      task all: [:quick, :teacher_photos]
      
      task product_types: :environment do
        p 'Populating product_types'
        ActiveRecord::Base.transaction do 
          read_csv('product_types').flatten.map do |product_type_name|
            ProductType.create!(name: product_type_name)
          end
        end
      end

      task populate: :environment do
        p 'Populating Teachers'
        create_teacher 'Andre Melo', 'Francisco Andre Melo Farias', ' francisco.andre@sistemaeliterio.com.br', 'andremelofarias@hotmail.com'
        create_teacher 'Eduardo Cesar', 'Eduardo Cesar Nogueira Coutinho', ' eduardo.cesar@sistemaeliterio.com.br', 'eduardocesar93@hotmail.com'
        create_teacher 'Fabio Soares', 'Fabio Soares', 'fabio.soares@sistemaeliterio.com.br', ' fabiopinheiro2007@yahoo.com.br'
        create_teacher 'Gustavo', 'Gustavo de Oliveira Menezes', ' gustavo.oliveira@sistemaeliterio.com.br', 'gom.menezes@gmail.com'
        create_teacher 'Igor Cesar', 'Igor Cesar Torres de Oliveira', ' igor.cesar@sistemaeliterio.com.br', 'igorctorres@hotmail.com'
        create_teacher 'Jessica Velasco', 'Jessica Velasco Francisco', 'jessica.velasco@sistemaeliterio.com.br', 'jessica_velascof@yahoo.com.br'
        create_teacher 'Joana Diafilos', 'Joana Diafilos Teixeira', 'joana.teixeira@sistemaeliterio.com.br', 'joanadteixeira@gmail.com'
        create_teacher 'Joao Paulo', 'Joao Paulo Gonçalves Rodrigues', 'joao.rodrigues@sistemaeliterio.com.br', 'pdc.joaopaulo@gmail.com'
        create_teacher 'Jorge Filho', 'Jorge da Paixao Marques Filho', 'jorge.marques@sistemaeliterio.com.br', 'jorge_geo.31@hotmail.com'
        create_teacher 'Jose Alexandre', 'Jose Alexandre Duarte', 'jose.alexandre@sistemaeliterio.com.br', ''
        create_teacher 'Jose Flavio', 'Jose Flavio Simoes Furtado', 'jose.flavio@sistemaeliterio.com.br', 'jose_flavio@oi.com.br'
        create_teacher 'Josineia Mendes', 'Josineia Mendes da Costa', 'josineia.costa@sistemaeliterio.com.br', 'josineia_yvi@hotmail.com'
        create_teacher 'Juliana Menezes', 'Juliana Almeida Bandeira de Menezes', 'juliana.menezes@sistemaeliterio.com.br', 'menezesjuliana04@gmail.com'
        create_teacher 'Julio Cesar', 'Julio Cesar Alves Ribeiro', 'julio.ribeiro@sistemaeliterio.com.br', 'juliostaley@yahoo.com.br'
        create_teacher 'Kariny', 'Kariny Soares Santos', 'kariny.soares@sistemaeliterio.com.br', 'kariny_soares_santos@hotmail.com'
        create_teacher 'Kelvin', 'Kelvin de Aguiar Macedo', ' kelvin.aguiar@sistemaeliterio.com.br', 'macedokelvin@gmail.com'
        create_teacher 'Kinda Lins', 'Kinda Bernardo Santos Lins', 'kinda.bernardo@sistemaeliterio.com.br', 'kindalins@gmail.com'
        create_teacher 'Kyle', 'Kyle Benjamin Zachary', 'kyle.benjamin@sistemaeliterio.com.br', ''
        create_teacher 'Leandro Ladi', 'Leandro Marques Ladi', 'leandro.ladi@sistemaeliterio.com.br', 'landroladiportugues@yahoo.com.br'
        create_teacher 'Leilane Norberto', 'Leilane Norberto da Silva', 'leilane.norberto@sistemaeliterio.com.br', 'leilanenorberto@gmail.com'
        create_teacher 'Leonardo Cordeiro', 'Leonardo Cordeiro Araujo da Fonseca', 'leonardo.cordeiro@sistemaeliterio.com.br', 'leocordeiroaf@yahoo.com.br'
        create_teacher 'Leonardo Manzano', 'Leonardo Viana Manzano', 'leonardo.manzano@sistemaeliterio.com.br', 'leomanza@globo.com'
        create_teacher 'Lidiane de Melo', 'Lidiane de Melo da Silva', 'lidiane.melo@sistemaeliterio.com.br', 'lidimaria@ig.com.br'
        create_teacher 'Ligia Albuquerque', 'Ligia de Albuquerque Carneiro', 'ligia.albuquerque@sistemaeliterio.com.br', 'ligia.albuquerque@hotmail.com'
        create_teacher 'Livia Silva', 'Livia Ferreira Alves da Silva', 'livia.ferreira@sistemaeliterio.com.br', 'livia.silv@uol.com.br'
        create_teacher 'Lucas Gabriel', 'Lucas Gabriel C. de Oliveira', 'lucas.oliveira@sistemaeliterio.com.br', 'nsvmudancas@gmail.com'
        create_teacher 'Lucas Jose', 'Lucas Jose Ribeiro', 'lucas.ribeiro@sistemaeliterio.com.br', 'lucasjribeiro@hotmail.com'
        create_teacher 'Lucas Maciel', 'Lucas Maciel Ribeiro', ' lucas.maciel@sistemaeliterio.com.br', 'luks1.1@hotmail.com'
        create_teacher 'Rafael Borges', 'Rafael Borges Elias', 'rafael.borges@sistemaeliterio.com.br', 'rafael_borges93@yahoo.com.br'
        create_teacher 'Rafael Faria', 'Rafael Vale Faria', ' rafael.vale@sistemaeliterio.com.br', 'rafavale.faria@yahoo.com.br'
        create_teacher 'Rafael Guedes', 'Rafael Pereira Guedes', 'rafael.pereira@sistemaeliterio.com.br', 'rafaelguedesbr@hotmail.com'
        create_teacher 'Rafael Mendes', 'Rafael Hugo Mendes da Silva', 'rafael.hugo@sistemaeliterio.com.br', 'leafarmendes@gmail.com'
        create_teacher 'Rafael Tavares', 'Rafael Tavares Freitas', 'rafael.tavares@sistemaeliterio.com.br', 'rafael.tavaress@hotmail.com'
        create_teacher 'Raphael Martins', 'Raphael Martins Gomes', 'raphael.martins@sistemaeliterio.com.br', 'raphaelmartinsuerj@yahoo.com.br'
        create_teacher 'Raphael Moura', 'Raphael Moura da Silva', 'raphael.moura@sistemaeliterio.com.br', 'raphaelmouraf@gmail.com'
        create_teacher 'Raquel Conceiçao', 'Raquel da Conceiçao dos Santos', 'raquel.conceicao@sistemaeliterio.com.br', 'raquelsts@gmail.com'
        create_teacher 'Raquel Freitas', 'Raquel Freitas de Lima', 'raquel.freitas@sistemaeliterio.com.br', 'raquelf@oi.com.br'
        create_teacher 'Regina Oliveira', 'Regina Pereira de Oliveira', 'regina.pereira@sistemaeliterio.com.br', 're_pdo@hotmail.com'
        create_teacher 'Reginaldo Colbert', 'Reginaldo Dias Colbert', 'reginaldo.colbert@sistemaeliterio.com.br', 'reginaldocolbert@gmail.com'
        create_teacher 'Renan Alexandre', 'Renan Alexandre da N. Santos', 'renan.santos@sistemaeliterio.com.br', 'tech.rox@hotmail.com'
        create_teacher 'Renato Coutinho', 'Renato Lucas Coutinho', 'renato.lucas@sistemaeliterio.com.br', 'renato_lucas@hotmail.com'
        create_teacher 'Ricardo Fagundes', 'Ricardo Fagundes Freitas da Cunha', 'ricardo.fagundes@sistemaeliterio.com.br', 'profrifa@hotmail.com'
        create_teacher 'Ricardo Francisco', 'Ricardo Francisco Marsico', 'ricardo.francisco@sistemaeliterio.com.br', 'ricardomarsico@crvasco.com.br'
        create_teacher 'Rita Carolina', 'Rita Carolina Ribeiro Martins', 'rita.carolina@sistemaeliterio.com.br', 'ritacarolina@bol.com.br'
        create_teacher 'Rodrigo Bueno', 'Rodrigo Ayupe Bueno da Cruz', 'rodrigo.bueno@sistemaeliterio.com.br', 'royupe@hotmail.com'
        create_teacher 'Rodrigo Gomes', 'Rodrigo Gomes Menezes', 'rodrigo.menezes@sistemaeliterio.com.br', 'al.rmenezes@hotmail.com'
        create_teacher 'Rodrigo Palma', 'Rodrigo Palma da Silva', 'rodrigo.silva@sistemaeliterio.com.br', 'digocael@hotmail.com'
        create_teacher 'Rodrigo Siqueira', 'Rodrigo Siqueira Moraes', 'rodrigo.moraes@sistemaeliterio.com.br', 'kamusdrigo@hotmail.com'
        create_teacher 'Rômulo Bolivar', 'Rômulo Flores Dias Bolivar', 'romulo.bolivar@sistemaeliterio.com.br', 'romulus_uerj@yahoo.com.br'
        create_teacher 'Ronaldo Fontinele', 'Ronaldo Augusto Soares Fontinele', 'ronaldo.fontinele@sistemaeliterio.com.br', 'ronaldofontinele@yahoo.com.br'
        create_teacher 'Rosana', 'Rosana Teixeira da Silva Borges', 'rosana.teixeira@sistemaeliterio.com.br', 'rosanatei8@gmail.com'
        create_teacher 'Samuel Chame', 'Samuel Chame', 'samuel.chame@sistemaeliterio.com.br', 'samuelchame@hotmail.com'
        create_teacher 'Sandro', 'Sandro Vicente e Silva', 'sandro.silva@sistemaeliterio.com.br', 'sandro_esp@yahoo.com.br'
        create_teacher 'Vivian Rodrigues', 'Vivian Maria Fernandes Rodrigues', 'vivian.fernandes@sistemaeliterio.com.br ', 'vivian.maria.13@hotmail.com'        
      end

      task product_groups: :environment do
        p 'Populating product_groups'
        ActiveRecord::Base.transaction do 
          read_csv('product_groups').flatten.each do |product_group_name|
            ProductGroup.create!(name: product_group_name)
          end
        end
      end

      task campuses: :environment do
        p 'Populating campuses'
        ActiveRecord::Base.transaction do 
          read_csv('campuses').each do |campus_name, code|
            Campus.create!(name: campus_name, code: code)
          end
        end
      end

      task subjects: :environment do
        p 'Populating subjects'
        ActiveRecord::Base.transaction do 
          read_csv('subjects').each do |subject_name, subject_short_name, subject_code|
            Subject.create!(
              name: subject_name, 
              short_name: subject_short_name, 
              code: subject_code)
          end
        end
      end

      task klazz_types: :environment do
        p 'Populating klazz_types'
        ActiveRecord::Base.transaction do 
          read_csv('klazz_types').flatten.each do |klazz_type_name|
            KlazzType.create!(name: klazz_type_name)
          end
        end
      end

      task majors: :environment do
        p 'Populating majors'
        ActiveRecord::Base.transaction do 
          read_csv('majors').flatten.each do |major_name|
            Major.create!(name: major_name)
          end
        end
      end

      task school_roles: :environment do
        p 'Populating school_roles'
        ActiveRecord::Base.transaction do 
          read_csv('school_roles').flatten.each do |school_role_name|
            SchoolRole.create!(name: school_role_name)
          end
        end
      end

      task elite_roles: :environment do
        p 'Populating elite_roles'
        ActiveRecord::Base.transaction do
          read_csv('elite_roles').each do |elite_role_name, school_role_name|
            EliteRole.create!(
              name: elite_role_name, 
              school_role_id: SchoolRole.find_by_name!(school_role_name).id)
          end
        end
      end

      task absence_reasons: :environment do
        p 'Populating absence_reasons'
        ActiveRecord::Base.transaction do
          read_csv('absence_reasons').flatten.each do |absence_reason_name|
            AbsenceReason.create!(name: absence_reason_name)
          end
        end
      end

      task employees: :environment do
        p 'Populating employees'
        ActiveRecord::Base.transaction do 
          read_csv('employees').each do |elite_id, chapa, name, email, date_of_birth,
              address, suburb, city, state,
              telephone, alternative_telephone, cellphone, alternative_cellphone,
              identification, expeditor, cpf, gender, marital_status,
              pis_pasep, working_paper_number, date_of_admission,
              cost_per_hour, personal_email, contract_type|
            address_attributes = {
              street: address,
              suburb: suburb,
              city: city,
              state: state,
              country: 'Brasil'}
            Employee.create!(
              elite_id: elite_id,
              chapa: chapa,
              name: name,
              email: email,
              date_of_birth: date_of_birth,
              address_attributes: address_attributes,
              telephone: telephone,
              alternative_telephone: alternative_telephone,
              cellphone: cellphone,
              alternative_cellphone: alternative_cellphone,
              identification: identification,
              expeditor: expeditor,
              cpf: cpf,
              gender: gender,
              marital_status: marital_status,
              pis_pasep: pis_pasep,
              working_paper_number: working_paper_number,
              date_of_admission: date_of_admission,
              cost_per_hour: cost_per_hour,
              personal_email: personal_email,
              contract_type: contract_type) 
          end
        end 
      end

      task teachers: :environment do
        p 'Populating teachers'
        ActiveRecord::Base.transaction do 
          read_csv('teachers').each do |elite_id, nickname|
            employee = Employee.find_by_elite_id!(elite_id.to_i)
            employee.update_attributes!(roles: employee.roles + ['teacher'])
            employee.create_teacher!(nickname: nickname.strip)
          end
        end
      end

      task admins: :environment do
        p 'Populating admins'
        ActiveRecord::Base.transaction do 
          read_csv('admins').flatten.each do |elite_id|
            employee = Employee.find_by_elite_id!(elite_id)
            employee.update_attributes!(roles: ['admin'])
            employee.create_admin!
          end
        end
      end

      task poll_question_types: :environment do
        p 'Populating question_types'
        ActiveRecord::Base.transaction do 
          read_csv('poll_question_types').flatten.each do |poll_question_type_name|
            PollQuestionType.create!(name: poll_question_type_name)
          end
        end
      end

      task poll_question_categories: :environment do
        p 'Populating question_categories'
        ActiveRecord::Base.transaction do 
          read_csv('poll_question_categories').flatten.each do |poll_question_category_name|
            PollQuestionCategory.create!(name: poll_question_category_name)
          end
        end
      end

      task teacher_photos: :environment do
        p 'Storing teacher_photos to database'
        file_extension = '.jpg'
        Dir.foreach(PHOTOS_PATH) do |filename|
          next if File.extname(filename) != file_extension
          employee = Employee.find_by_elite_id!(File.basename(filename, file_extension))
          employee.photo.store!(File.open(File.join(PHOTOS_PATH)))
          employee.save!
        end
      end

      task products: :environment do
        p 'Populating products'
        ActiveRecord::Base.transaction do 
          read_csv('products').each do |product_name, product_type_name, prefix, suffix, product_group_name, code|
            Product.create!(
              name: product_name, 
              product_type_id: ProductType.find_by_name!(product_type_name).id,
              prefix: prefix,
              suffix: suffix,
              product_group_id: ProductGroup.where(name: product_group_name).first.try(:id),
              code: code)
          end
        end
      end

      task years: :environment do
        p 'Populating years'
        Year.create!(number: 2013, start_date: '2013-2-18', end_date: '2013-12-23')
      end

      task product_years: :environment do
        p 'Populating product years'
        ActiveRecord::Base.transaction do 
          read_csv('products').each do |product_name, product_type_name, prefix, suffix, product_group_name, code|
            ProductYear.create!(
              name: product_name + ' - ' + Year.first.number.to_s, 
              product_id: Product.where(name: product_name).first!.id, 
              year_id: Year.first.id)
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
          student_coordinates: CARD_STUDENT_COORDINATES)
      end

      task campus_head_teachers: :environment do 
        p 'Populating campus head teachers'
        ActiveRecord::Base.transaction do 
          all_product_ids = Product.all.map(&:id)
          read_csv('campus_head_teachers').each do |elite_id, name, email, *campus_names|
            employee = Employee.where(elite_id: elite_id.to_i).first!
            employee.update_attributes!(email: email, roles: employee.roles + %w[campus_head_teacher])

            campus_ids = campus_names.map do |campus_name|
              Campus.where(name: campus_name).first!.id
            end
            employee.create_campus_head_teacher!(
              product_ids: all_product_ids,
              campus_ids: campus_ids)
          end
        end
      end

      def create_teacher nickname, name, email, personal_email
        e = Employee.new
        e.name = name
        e.elite_id = Employee.where("elite_id < 100000").map(&:elite_id).max + 1
        e.email = email
        e.personal_email = personal_email
        e.save
        t = Teacher.new
        t.employee_id = e.id
        t.nickname = nickname
        t.save
        t.update_column(:updated_at, '2013-10-29')
      end

    end
  end
end
