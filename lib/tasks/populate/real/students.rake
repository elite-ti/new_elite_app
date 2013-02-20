namespace :db do
  namespace :populate do
    namespace :real do 
      task students: :environment do
        p 'Populating students'
        ActiveRecord::Base.transaction do 
          read_csv('students').map do |campus_name, student_name, product_campus_turno|
            campus = find_campus(campus_name)
          end
        end
      end

      def find_campus(campus_name)
        if campus_name = 'NAO INFORMADO'
          return nil
        else
          campus_name = campus_name.gsub(/Elite /, '')
          return Campus.where(name: campus_name).first!
        end 
      end
    end
  end
end
