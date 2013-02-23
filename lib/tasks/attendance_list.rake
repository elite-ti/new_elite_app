namespace :db do
  namespace :populate do
    namespace :real do 
      task attendance_list: :environment do
        p 'Creating xls'
        number_of_students = []
        desktop = '/home/charlie/Desktop/csvs'
        Campus.all.each do |campus|
          ProductYear.all.each do |product_year|
            product = product_year.product
            klazzes = Klazz.where(campus_id: campus.id, product_year_id: product_year.id).all

            next if klazzes.empty? 

            students = klazzes.map(&:enrolled_students).flatten.uniq
            number_of_students << students.size

            uri = "#{campus.name}_#{product.name}.csv"
            uri.gsub!(/\//, '$')
            CSV.open("#{desktop}/" + uri, "wb") do |csv|
              students.each do |student|
                csv << [student.ra, student.name]
              end
            end

            prefix = '9' + campus.code + product.code
            uri = "#{campus.name}_#{product.name}_temporary.csv"
            uri.gsub!(/\//, '$')
            CSV.open("#{desktop}/" + uri, "wb") do |csv|
              80.times do |i|
                temporary_ra = prefix + "%02d" % i
                csv << [temporary_ra]
              end
            end
          end
        end

        pp number_of_students.sort
      end
    end
  end
end
