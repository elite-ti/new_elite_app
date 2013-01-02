namespace :db do
  namespace :populate do
    ASSETS_PATH = File.join(Rails.root, 'lib/assets/populate')

    def read_csv(file_name)
      CSV.read File.join(ASSETS_PATH, file_name + '.csv')
    end

    task time_tables: :environment do
      p 'Populating time_tables'
      ActiveRecord::Base.transaction do
        read_csv('time_tables').each do |elite_id, klazz_name, subject_name, date, klazz_type_name, position|
          TimeTable.create!(
            teacher_id: Employee.find_by_elite_id!(elite_id).teacher.id,
            klazz_id: Klazz.find_by_name!(klazz_name).id,
            subject_id: Subject.find_by_name!(subject_name).id,
            date: date,
            klazz_type_id: KlazzType.find_by_name!(klazz_type_name).id,
            position: position
          )
        end
      end
    end
  end
end