# encoding: UTF-8
namespace :db do
  namespace :populate do
    namespace :old do 
      task periods: :environment do
        p 'Populating periods'
        ActiveRecord::Base.transaction do
          read_csv('periods').each do |elite_id, klazz_name, subject_name, date, klazz_type_name, position|
            Period.create!(
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
end
