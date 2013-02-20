set_default(:remote_user) { application }
set_default(:remote_db) { "#{application}_production" }

namespace :db do
  desc 'Create a db dump in your vps and download the file'
  task :dump, roles: :db, only: {primary: true} do
    dumps_path = 'dumps/'
    run "mkdir -p #{dumps_path}"

    filename = "#{remote_db}_#{Time.now.strftime('%Y-%m-%d_%H:%M')}_UTC.sql"
    file_path = File.join(dumps_path, filename)
    run "#{sudo} -u postgres pg_dump #{remote_db} > #{file_path}"
    download file_path, "/home/charlie/Desktop/#{filename}"
  end

  # desc 'Save and download uploads'
  # task :uploads, roles: :db, only: {primary: true} do
  #   dumps_path = 'dumps/'
  #   run "mkdir -p #{dumps_path}"

  #   filename = "#{remote_db}_#{Time.now.strftime('%Y-%m-%d_%H:%M')}_UTC.sql"
  #   file_path = File.join(dumps_path, filename)
  #   run "#{sudo} -u postgres pg_dump #{remote_db} > #{file_path}"
  #   download file_path, "/home/charlie/Desktop/#{filename}"
  # end

  desc 'Populate database'
  task :populate, roles: :db, only: {primary: true} do
    run "cd #{current_path} && bundle exec rake RAILS_ENV=production db:populate:production"
  end
  before 'db:populate', 'db:dump'
end
