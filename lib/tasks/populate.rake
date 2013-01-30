namespace :db do
  namespace :populate do

    ASSETS_PATH = File.join(Rails.root, 'lib/tasks/populate/csvs')

    def read_csv(file_name)
      CSV.read File.join(ASSETS_PATH, file_name + '.csv')
    end
    
    task general: [
      :product_types, :product_groups, :products, :years, :campuses, 
      :klazzes, :subjects, :klazz_types, :majors, :school_roles, 
      :elite_roles, :absence_reasons, :employees, :teachers, :admins, 
      :poll_question_types, :poll_question_categories
    ]

    task go_grab_a_coffee: [:time_tables, :teacher_photos]

    task clean_uploads: :environment do
      FileUtils.rm_rf(File.join(Rails.root, 'public/uploads'))
    end

    # Junk

    task my_all: [:clean_uploads, 'db:schema:load', :general, :exam_related]
  end
end
