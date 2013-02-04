namespace :db do
  namespace :populate do
    ASSETS_PATH = File.join(Rails.root, 'lib/tasks/populate/csvs')

    def read_csv(file_name)
      CSV.read File.join(ASSETS_PATH, file_name + '.csv')
    end
    
    task to_test: [
      'db:schema:load', 
      :clean_uploads, 
      'db:populate:real:quick', 
      'db:populate:faike:all'
    ]

    task clean_uploads: :environment do
      FileUtils.rm_rf(File.join(Rails.root, 'public/uploads'))
    end
  end
end
