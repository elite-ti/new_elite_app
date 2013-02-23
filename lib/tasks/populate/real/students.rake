namespace :db do
  namespace :populate do
    namespace :real do 
      task students: :environment do
        p 'Populating students'
        ActiveRecord::Base.transaction do 
          read_csv('students').each do |ra, name, klazz_name|
            name = name.split(/\s+/).map(&:mb_chars).map(&:capitalize).join(' ')
            student = Student.where(ra: ra.to_i).first_or_create!(name: name)

            klazz = Klazz.where(name: klazz_name).first
            if klazz.present?
              Enrollment.where(student_id: student.id, klazz_id: klazz.id).first_or_create!
            else
              parsed_klazz_name = klazz_name.match(/(.*)-AES(.)(.)/)
              if parsed_klazz_name
                product_year = Product.where(prefix: 'AES').first!.product_years.first!
                campus = Campus.where(code: parsed_klazz_name[1]).first!
                Klazz.create!(
                  name: klazz_name,
                  product_year_id: product_year.id,
                  campus_id: campus.id)
              else
                p 'Klazz not found: ' + klazz_name
              end
            end
          end 
        end
      end

      task check_not_found_klazzes: :environment do 
        p 'Not found klazzes'
        read_csv('students').each do |ra, name, klazz_name|
          p "#{ra},#{name},#{klazz_name}" if %w[#N/A #VALUE!].include?(klazz_name)
        end
      end

      task check_repeated_students: :environment do 
        table = read_csv('students').sort do |x, y| x[0] <=> y[0] end.uniq
        ras = table.map do |row| row[0] end
        repeated_ra_indexes = []

        (ras.size - 1).times do |i| 
          if ras[i] == ras[i + 1]
            repeated_ra_indexes << i 
            repeated_ra_indexes << i + 1
          end
        end
        repeated_ra_indexes.uniq!

        p 'Repeated Students'
        repeated_ra_indexes.each do |ra_index|
          row = table[ra_index]
          p row.join(',') 
        end
      end
    end
  end
end
