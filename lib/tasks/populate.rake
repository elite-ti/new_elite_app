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

    task exam_related: [:card_type, :exam_cycle, :questions, :exam]

    task go_grab_a_coffee: [:time_tables, :teacher_photos]

    task clean_uploads: :environment do
      FileUtils.rm_r(File.join(Rails.root, 'public/uploads'))
    end

    task testing_card_processor: [:clean_uploads, 'db:schema:load', :general, :exam_related]

    task :testing_card_upload do
      p 'Erasing uploads'
      FileUtils.rm_rf(File.join(Rails.root, 'public/uploads'))

      p 'Erasing db'
      `sudo -u postgres dropdb elite_app_development`
      `sudo -u postgres createdb elite_app_development -O new_elite_app`

      p 'Restoting db'
      `sudo -u postgres psql elite_app_development < ~/Desktop/task/dump.sql`

      p 'Restoting uploads'
      `cp -r ~/Desktop/task/uploads ~/code/new_elite_app/public/`
    end

  end
end
