#encoding: utf-8

namespace :db do
  namespace :populate do
    namespace :real do 
      # Set this path to where you saved teachers photos
      PHOTOS_PATH = ''
      ASSETS_PATH = File.join(Rails.root, 'lib/tasks/populate/real/csvs')
      
      CARD_PATH = "#{Rails.root}/spec/support/card_c.tif"
      CARD_PARAMETERS = '0.4 60 540 80 40 2900 4229 2 1222 8 0123456789 79 38 314 702 990 408 2 691 50 ABCDE 77 38 846 1185 486 2659'
      CARD_STUDENT_COORDINATES = '"2900x1050+0+0'

      task quick: [
        :product_types, :products, :years, :product_years, :campuses, 
        :subjects, :employees, :admins, :card_types, :super_klazzes, :klazzes, :students]

      task all: [:quick, :teacher_photos]
      
      task product_types: :environment do
        p 'Populating product_types'
        ActiveRecord::Base.transaction do 
          read_csv('product_types').flatten.map do |product_type_name|
            ProductType.create!(name: product_type_name)
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

      task employees: :environment do
        p 'Populating employees'
        ActiveRecord::Base.transaction do 
          read_csv('employees').each do |name, email|
            Employee.create!(
              name: name,
              email: email)
          end
        end 
      end

      task admins: :environment do
        p 'Populating admins'
        ActiveRecord::Base.transaction do 
          read_csv('admins').flatten.each do |id|
            employee = Employee.find_by_id!(id)
            employee.update_attributes!(roles: ['admin'])
            employee.create_admin!
          end
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
        Year.create!(number: 2014, start_date: '2014-02-04', end_date: '2014-12-23')
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
          name: 'Cartão A4', 
          command: 'type_a',
          parameters: CARD_PARAMETERS,
          student_coordinates: CARD_STUDENT_COORDINATES)
      end

      task super_klazzes: :environment do
        p 'Populating Super Klazzes'
        ActiveRecord::Base.transaction do 
          read_csv('super_klazzes').each do |campus_name, product_name|
            SuperKlazz.create!(
              campus_id: Campus.find_by_name(campus_name).id, 
              product_year_id: ProductYear.find_by_name(product_name + ' - ' + Year.first.number.to_s).id)
          end
        end
      end

      task klazzes: :environment do
        p 'Populating Klazzes'
        ActiveRecord::Base.transaction do 
          read_csv('klazzes').each do |klazz_name, campus_name, product_name|
            Klazz.create!(
              name: campus_name + ' - ' + klazz_name, 
              super_klazz_id: SuperKlazz.where(campus_id: Campus.find_by_name(campus_name).id, product_year_id: ProductYear.find_by_name(product_name + ' - ' + Year.first.number.to_s).id).first.id)
          end
        end
      end

      task students: :environment do
        p 'Populating Students'
        ActiveRecord::Base.transaction do 
          read_csv('students').each do |ra, student_name, campus_name, product_name, klazz_name|
            begin
              p "#{ra},#{student_name},#{campus_name},#{product_name},#{klazz_name}"
              student = Student.where(ra: ra.to_i).first_or_create!(name: student_name)
              Enrollment.create!(
                student_id: student.id, 
                super_klazz_id: SuperKlazz.where(campus_id: Campus.find_by_name(campus_name).id, product_year_id: ProductYear.find_by_name(product_name + ' - ' + Year.first.number.to_s).id).first.id,
                klazz_id: Klazz.find_by_name(campus_name + ' - ' + klazz_name).id)              
            rescue Exception => e
              p 'ERRO! ' + e.message
            end
          end
        end
      end

      task exam_executions: :environment do
        p 'Populating Exams'
        ActiveRecord::Base.transaction do 
          read_csv('exams').each do |exam_code, datetime, campus_name, product_name, exam_name, cycle_name, subjects, answers|
            p "#{exam_code},#{datetime},#{campus_name},#{product_name},#{exam_name},#{cycle_name},#{subjects},#{answers}"
            exam = Exam.create!(
              name: exam_name + ' - ' + product_name,
              options_per_question: 5,
              correct_answers: '',
              code: exam_code)
            campuses = campus_name == 'Todas' ? Campus.all : Campus.find_by_name(campus_name)
            exam_cycle_id = ExamCycle.where(name: cycle_name + ' - ' + product_name).first_or_create!(is_bolsao: false, product_year_id: ProductYear.find_by_name(product_name + ' - ' + Year.first.number.to_s).id).id
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
        end
      end      

    end
  end
end
