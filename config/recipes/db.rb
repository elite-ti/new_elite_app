set_default(:remote_user) { application }
set_default(:remote_db) { "#{application}_production" }

namespace :db do
  desc 'Create a db dump in your vps and download the file'
  task :dump, roles: :db, only: {primary: true} do
    run "mkdir -p "
    filename = "#{remote_db}_#{Time.now.strftime('%Y-%m-%d_%H:%M')}_UTC.sql"
    file_path = "/home/#{user}/dumps/#{filename}"
    run "#{sudo} -u postgres pg_dump #{remote_db} > #{file_path}"
    get file_path, '~/'
  end

  desc 'Populate database'
  task :populate, roles: :db, only: {primary: true} do
    run "cd #{current_path} && bundle exec rake RAILS_ENV=production db:populate:production"
  end
  before 'db:populate', 'db:dump'
end
