set_default(:remote_user) { application }
set_default(:remote_db) { "#{application}_production" }

namespace :db do
  desc 'Create a db dump in your vps and download the file'
  task :dump, roles: :db, only: {primary: true} do
    dumps_path = 'dumps/'
    run "mkdir -p #{dumps_path}"

    filename = "#{remote_db}_#{Time.now.strftime('%Y%m%d%H%M')}.sql"
    file_path = File.join(dumps_path, filename)
    run "#{sudo} -u postgres pg_dump #{remote_db} > #{file_path}"
    download file_path, "/home/charlie/Desktop/#{filename}"
  end

  desc 'Save and download uploads'
  task :uploads, roles: :db, only: {primary: true} do
    uploads_path = 'uploads/'
    run "mkdir -p #{uploads_path}"

    filename = "#{application}_uploads_#{Time.now.strftime('%Y%m%d%H%M')}.zip"
    file_path = File.join(uploads_path, filename)
    if File.exist?(file_path)
      run "zip -r #{file_path} #{current_path}/public/uploads"
      download file_path, "/home/charlie/Desktop/#{filename}"
    end
  end

  desc 'Populate database'
  task :populate, roles: :db, only: {primary: true} do
    run "cd #{current_path} && bundle exec rake RAILS_ENV=production db:populate:production"
  end
  before 'db:populate', 'db:dump'
  before 'db:populate', 'db:uploads'
end
