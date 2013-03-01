# encoding: UTF-8
namespace :db do
  namespace :populate do
    namespace :real do 
      task temporary_students: :environment do
        p 'Populating temporary students'
        ActiveRecord::Base.transaction do 
          read_csv('temporary_students', col_sep: ';').each do |name, product_name, campus_name|

            product_name = {
              "1ºMilitar" => "1ª Série Militar", 
              "2ºMilitar" => "2ª Série Militar", 
              "AFA- EFOMM-ESPCEX" => "AFA/ESPCEX", 
              "9ºMilitar" => "9º Ano Militar", 
              "AFA-EAAr-EFOMM" => "AFA/EAAr/EFOMM", 
              "AFA-ESPCEX" => "AFA/ESPCEX", 
            }[product_name] || product_name

            super_klazz = SuperKlazz.where(
              product_year_id: ProductYear.where(name: product_name + ' - 2013').first!.id, 
              campus_id: Campus.where(name: campus_name).first!.id).first_or_create!

            # p "SuperKlazz: " + super_klazz.name
            # p "Student: " + name
            # p ""

            name = name.split(/\s+/).map(&:mb_chars).map(&:capitalize).join(' ')
            student = Student.create_temporary_student!(name, super_klazz.id)
          end 
        end
      end
    end
  end
end
