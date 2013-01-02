# This rake does not export every data in the database
# To back the data up use `sudo -u postgres pg_dump <database_name>`

namespace :db do
  namespace :export do
    EXPORT_PATH = File.join(Rails.root, 'lib/assets/export')

    def export_path(filename)
      File.join(EXPORT_PATH, filename + '.csv')
    end

    task all: [
      :product_types, :product_groups, :products, :years, :campuses, :klazzes, 
      :subjects, :klazz_types, :majors, :school_roles, :elite_roles, :absence_reasons, 
      :employees, :teachers, :admins, :time_tables,
      :question_types, :question_categories
    ]

    task product_types: :environment do
      p 'Exporting product_types'
      CSV.open(export_path('product_types'), 'wb') do |csv|
        ProductType.all.each do |x|
          csv << [x.name]
        end
      end
    end

    task product_groups: :environment do
      p 'Exporting product_groups'
      CSV.open(export_path('product_groups'), 'wb') do |csv|
        ProductGroup.all.each do |x|
          csv << [x.name]
        end
      end
    end

    task products: :environment do
      p 'Exporting products'
      CSV.open(export_path('products'), 'wb') do |csv|
        Product.includes(:product_type, :product_group).all.each do |x|
          csv << [x.name, x.product_type.name, x.product_group.try(:name)]
        end
      end
    end

    task years: :environment do
      p 'Exporting years'
      CSV.open(export_path('years'), 'wb') do |csv|
        Year.includes(:product).all.each do |x|
          csv << [x.name, x.product.name]
        end
      end
    end

    task campuses: :environment do
      p 'Exporting campuses'
      CSV.open(export_path('campuses'), 'wb') do |csv|
        Campus.all.each do |x|
          csv << [x.name]
        end
      end
    end

    task klazzes: :environment do
      p 'Exporting klazzes'
      CSV.open(export_path('klazzes'), 'wb') do |csv|
        Klazz.includes(:year, :campus).all.each do |x|
          csv << [x.name, x.year.name, x.campus.name]
        end
      end
    end

    task subjects: :environment do
      p 'Exporting subjects'
      CSV.open(export_path('subjects'), 'wb') do |csv|
        Subject.all.each do |x|
          csv << [x.name, x.short_name, x.code]
        end
      end
    end

    task klazz_types: :environment do
      p 'Exporting klazz_types'
      CSV.open(export_path('klazz_types'), 'wb') do |csv|
        KlazzType.all.each do |x|
          csv << [x.name]
        end
      end
    end

    task majors: :environment do
      p 'Exporting majors'
      CSV.open(export_path('majors'), 'wb') do |csv|
        Major.all.each do |x|
          csv << [x.name]
        end
      end
    end

    task school_roles: :environment do
      p 'Exporting school_roles'
      CSV.open(export_path('school_roles'), 'wb') do |csv|
        SchoolRole.all.each do |x|
          csv << [x.name]
        end
      end
    end

    task elite_roles: :environment do
      p 'Exporting elite_roles'
      CSV.open(export_path('elite_roles'), 'wb') do |csv|
        EliteRole.includes(:school_role).all.each do |x|
          csv << [x.name, x.school_role.name]
        end
      end
    end

    task absence_reasons: :environment do
      p 'Exporting absence_reasons'
      CSV.open(export_path('absence_reasons'), 'wb') do |csv|
        AbsenceReason.all.each do |x|
          csv << [x.name]
        end
      end
    end

    task employees: :environment do
      p 'Exporting employees'
      CSV.open(export_path('employees'), 'wb') do |csv|
        Employee.all.each do |e|
          csv << [
            e.elite_id, e.chapa, e.name, e.email, e.date_of_birth,
            e.address, e.suburb, e.city, e.state,
            e.telephone, e.alternative_telephone,
            e.cellphone, e.alternative_cellphone,
            e.identification, e.expeditor, e.cpf,
            e.gender, e.marital_status,
            e.pis_pasep, e.working_paper_number, e.date_of_admission,
            e.cost_per_hour, e.personal_email, e.contract_type
          ]
        end
      end
    end

    task teachers: :environment do 
      p 'Exporting teachers'
      CSV.open(export_path('teachers'), 'wb') do |csv|
        Teacher.includes(:employee).all.each do |t|
          csv << [t.employee.elite_id, t.nickname]
        end
      end
    end

    task admins: :environment do
      p 'Exporting admins'
      # CSV.open(export_path('admins'), 'wb') do |csv| 
      #   Admin.includes(:employee).all.each do |t| 
      #     csv << [t.employee.elite_id]
      #   end
      # end
    end

    task time_tables: :environment do 
      p 'Exporting time_tables'
      CSV.open(export_path('time_tables'), 'wb') do |csv|
        TimeTable.includes(
          {teaching_assignment: [:klazz, :subject, {teacher: :employee}]}, :klazz_type
        ).all.each do |t|
          ta = t.teaching_assignment
          csv << [
            ta.teacher.employee.elite_id, ta.klazz.name, ta.subject.name,
            t.date, t.klazz_type.name, t.position
          ]
        end
      end
    end

    task question_types: :environment do
      p 'Exporting question_types'
      # CSV.open(export_path('question_types'), 'wb') do |csv|
      #   QuestionType.all.each do |x|
      #     csv << [x.name]
      #   end
      # end
    end

    task question_categories: :environment do
      p 'Exporting question_categories'
      # CSV.open(export_path('question_categories'), 'wb') do |csv|
      #   QuestionCategory.all.each do |x|
      #     csv << [x.name]
      #   end
      # end
    end
  end
end