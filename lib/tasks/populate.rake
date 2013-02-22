namespace :db do
  namespace :populate do
    def read_csv(file_name, *options)
      CSV.read File.join(ASSETS_PATH, file_name + '.csv'), *options
    end
    
    task development: [
      'db:schema:load', 
      :clean_uploads, 
      'db:populate:real:quick',
      'db:populate:real:periods',
      'db:populate:real:students',
      'db:populate:fake:all'
    ]

    task production: [
      # 'db:schema:load', 
      # :clean_uploads, 
      # 'db:populate:real:quick',
      # 'db:populate:real:periods:all',
      # 'db:populate:fake:all'
    ]

    task clean_uploads: :environment do
      FileUtils.rm_rf(File.join(Rails.root, 'public/uploads'))
    end
  end
end
