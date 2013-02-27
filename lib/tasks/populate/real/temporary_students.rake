# encoding: UTF-8
namespace :db do
  namespace :populate do
    namespace :real do 
      task temporary_students: :environment do
        p 'Populating temporary students'
        ActiveRecord::Base.transaction do 
          read_csv('temporary_students', col_sep: ';').each do |ra, name, product_name, campus_name|
            name = name.split(/\s+/).map(&:mb_chars).map(&:capitalize).join(' ')
            student = Student.create!(name: name, ra: ra)

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
            Enrollment.create!(student_id: student.id, super_klazz_id: super_klazz.id)
          end 
        end
      end

      task check_temporary_students: :environment do 
        p 'Checking temporary students'
        ActiveRecord::Base.transaction do 
          t = read_csv('temporary_students', col_sep: ';')
          product_names = t.map do |tt| tt[2] end.uniq
          campus_names = t.map do |tt| tt[3] end.uniq

          product_names.each do |product_name|
            if ["AFA-ESPCEX", "AFA-EAAr-EFOMM"].include?(product_name)
              product_name.gsub!(/-/, '/')
            end
            if Product.where(name: product_name).empty?
              p product_name
            end
          end

          campus_names.each do |campus_name|
            if Campus.where(name: campus_name).empty?
              p campus_name
            end
          end
        end
      end
    end
  end
end
