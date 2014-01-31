#encoding: utf-8

namespace :db do
  namespace :populate do
    namespace :real do 
      # Set this path to where you saved teachers photos
      PHOTOS_PATH = ''
      ASSETS_PATH = File.join(Rails.root, 'lib/tasks/populate/real/csvs')
      
      CARD_A_PATH = "#{Rails.root}/spec/support/card_b.tif"
      CARD_A_PARAMETERS = '0.4 60 540 80 40 1284 4847 1 0 7 0123456789 79 38 271 540 964 453 2 600 50 ABCDE 77 38 170 1054 473 3454'
      CARD_A_STUDENT_COORDINATES = '1280x1000+0+0'

      task quick: [
        :product_types, :products, :years, :product_years, :campuses, 
        :subjects, :employees, :admins, :card_types, :super_klazzes, :klazzes]

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
          command: 'type_b',
          parameters: CARD_PARAMETERS,
          student_coordinates: CARD_STUDENT_COORDINATES)
      end

      task super_klazzes: :environment do
        p 'Populating Super Klazzes'
        ActiveRecord::Base.transaction do 
          read_csv('super_klazzes').flatten.each do |campus_name, product_name|
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
              super_klazz_id: SuperKlazz.where(campus_id: Campus.find_by_name(campus_name).id, product_year_id: ProductYear.find_by_name(product_name + ' - ' + Year.first.number.to_s).id).id, 
              year_id: Year.first.id)
          end
        end
      end

    end
  end
end
