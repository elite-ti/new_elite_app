namespace :db do
  namespace :populate do
    ASSETS_PATH = File.join(Rails.root, 'lib/assets/populate')

    def read_csv(file_name)
      CSV.read File.join(ASSETS_PATH, file_name + '.csv')
    end
    
    task all: [
      'db:schema:load',
      :product_types, :product_groups, :products, :years, :campuses, :klazzes, 
      :subjects, :klazz_types, :majors, :school_roles, :elite_roles, :absence_reasons, 
      :employees, :teachers, :admins, :poll_question_types, :poll_question_categories
    ]

    task product_types: :environment do
      p 'Populating product_types'
      product_types = []
      read_csv('product_types').flatten.map do |product_type_name|
        product_types << {name: product_type_name}
      end
      ActiveRecord::Base.transaction { ProductType.create!(product_types) }
    end

    task product_groups: :environment do
      p 'Populating product_groups'
      product_groups = []
      read_csv('product_groups').flatten.each do |product_group_name|
        product_groups << {name: product_group_name}
      end
      ActiveRecord::Base.transaction { ProductGroup.create!(product_groups) }
    end

    task products: :environment do
      p 'Populating products'
      products = []
      read_csv('products').each do |product_name, product_type_name, product_group_name|
        products << {
          name: product_name, 
          product_type_id: ProductType.find_by_name!(product_type_name).id,
          product_group_id: ProductGroup.find_by_name(product_group_name).try(:id)
        }
      end
      ActiveRecord::Base.transaction { Product.create!(products) }
    end

    task years: :environment do
      p 'Populating years'
      years = []
      read_csv('years').each do |year_name, product_name|
        years << {name: year_name, product_id: Product.find_by_name!(product_name).id}
      end
      ActiveRecord::Base.transaction { Year.create!(years) }
    end

    task campuses: :environment do
      p 'Populating campuses'
      campuses = []
      read_csv('campuses').flatten.each do |campus_name|
        campuses << {name: campus_name}
      end
      ActiveRecord::Base.transaction { Campus.create!(campuses) }
    end

    task klazzes: :environment do
      p 'Populating klazzes'
      klazzes = []
      read_csv('klazzes').each do |klazz_name, year_name, campus_name|
        klazzes << {
          name: klazz_name, 
          year_id: Year.find_by_name!(year_name).id, 
          campus_id: Campus.find_by_name!(campus_name).id
        }
      end
      ActiveRecord::Base.transaction { Klazz.create!(klazzes) }
    end

    task subjects: :environment do
      p 'Populating subjects'
      subjects = []
      read_csv('subjects').each do |subject_name, subject_short_name, subject_code|
        subjects << {name: subject_name, short_name: subject_short_name, code: subject_code}
      end
      ActiveRecord::Base.transaction { Subject.create!(subjects) }
    end

    task klazz_types: :environment do
      p 'Populating klazz_types'
      klazz_types = []
      read_csv('klazz_types').flatten.each do |klazz_type_name|
        klazz_types << {name: klazz_type_name}
      end
      ActiveRecord::Base.transaction { KlazzType.create!(klazz_types) }
    end

    task majors: :environment do
      p 'Populating majors'
      majors = []
      read_csv('majors').flatten.each do |major_name|
        majors << {name: major_name}
      end
      ActiveRecord::Base.transaction { Major.create!(majors) }
    end

    task school_roles: :environment do
      p 'Populating school_roles'
      school_roles = []
      read_csv('school_roles').flatten.each do |school_role_name|
        school_roles << {name: school_role_name}
      end
      ActiveRecord::Base.transaction { SchoolRole.create!(school_roles) }
    end

    task elite_roles: :environment do
      p 'Populating elite_roles'
      elite_roles = []
      read_csv('elite_roles').each do |elite_role_name, school_role_name|
        elite_roles << {name: elite_role_name, school_role_id: SchoolRole.find_by_name!(school_role_name).id}
      end
      ActiveRecord::Base.transaction { EliteRole.create!(elite_roles) }
    end

    task absence_reasons: :environment do
      p 'Populating absence_reasons'
      absence_reasons = []
      read_csv('absence_reasons').flatten.each do |absence_reason_name|
        absence_reasons << {name: absence_reason_name}
      end
      ActiveRecord::Base.transaction { AbsenceReason.create!(absence_reasons) }
    end

    task employees: :environment do
      p 'Populating employees'
      employees = []
      read_csv('employees').each do |elite_id, chapa, name, email, date_of_birth,
          address, suburb, city, state,
          telephone, alternative_telephone,
          cellphone, alternative_cellphone,
          identification, expeditor, cpf,
          gender, marital_status,
          pis_pasep, working_paper_number, date_of_admission,
          cost_per_hour, personal_email, contract_type|
        employees << {
          elite_id: elite_id,
          chapa: chapa,
          name: name,
          email: email,
          date_of_birth: date_of_birth,
          address: address,
          suburb: suburb,
          city: city,
          state: state,
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
          contract_type: contract_type
        }
      end
      ActiveRecord::Base.transaction { Employee.create!(employees) }
    end

    task teachers: :environment do
      p 'Populating teachers'
      read_csv('teachers').each do |elite_id, nickname|
        employee = Employee.find_by_elite_id!(elite_id)
        employee.update_attributes!(roles: ['teacher'])
        employee.create_teacher!(nickname: nickname)
      end
    end

    task admins: :environment do
      p 'Populating admins'
      read_csv('admins').flatten.each do |elite_id|
        employee = Employee.find_by_elite_id!(elite_id)
        employee.update_attributes!(roles: ['admin'])
        employee.create_admin!
      end
    end

    task poll_question_types: :environment do
      p 'Populating question_types'
      poll_question_types = []
      read_csv('poll_question_types').flatten.each do |poll_question_type_name|
        poll_question_types << {name: poll_question_type_name}
      end
      PollQuestionType.create!(poll_question_types)
    end

    task poll_question_categories: :environment do
      p 'Populating question_categories'
      poll_question_categories = []
      read_csv('poll_question_categories').flatten.each do |poll_question_category_name|
        poll_question_categories << {name: poll_question_category_name}
      end
      PollQuestionCategory.create!(poll_question_categories)
    end
  end
end