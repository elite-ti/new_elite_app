namespace :super_klazz do
  task create_attendance_list: :environment do
    p 'Creating attendance list'

    folder = '/home/charlie/Desktop/attendance'
    SuperKlazz.includes(:campus, product_year: :product).all.each do |super_klazz|
      uri = "#{super_klazz.campus.name}_#{super_klazz.product_year.product.name}.csv"
      uri.gsub!(/\//, '-')

      CSV.open("#{folder}/" + uri, "wb") do |csv|
        super_klazz.enrolled_students.each do |student|
          csv << [student.ra, student.name]
        end
      end

      # prefix = '9' + campus.code + product.code
      # uri = "#{campus.name}_#{product.name}_temporary.csv"
      # uri.gsub!(/\//, '-')
      # CSV.open("#{desktop}/" + uri, "wb") do |csv|
      #   80.times do |i|
      #     temporary_ra = prefix + "%02d" % i
      #     csv << [temporary_ra]
      #   end
      # end
    end
  end

  task create_exam_results: :environment do 
    p 'Creating exam results'
    folder = '/home/charlie/Desktop/exam_results'

    SuperKlazz.includes(:campus, product_year: :product).all.each do |super_klazz|
      uri = "#{super_klazz.campus.name}_#{super_klazz.product_year.product.name}.csv"
      uri.gsub!(/\//, '-')
      
      CSV.open("#{folder}/" + uri, "wb") do |csv|
        super_klazz.student_exams.each do |student_exam|
          csv << [
            student_exam.student.ra, 
            student_exam.student.name, 
            student_exam.get_exam_answers.join('')
          ]
        end
      end
    end
  end
end
