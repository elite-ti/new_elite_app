set_default(:remote_user) { application }
set_default(:remote_db) { "#{application}_production" }

namespace :bkp do
  desc 'Backup db dump'
  task :dump, roles: :db, only: {primary: true} do
    dumps_bkp_path = 'dumps_bkp'
    run "mkdir -p #{dumps_bkp_path}"

    filename = "#{remote_db}_#{Time.now.strftime('%Y%m%d%H%M')}.sql"
    file_path = File.join(dumps_bkp_path, filename)
    run "#{sudo} -u postgres pg_dump #{remote_db} > #{file_path}"
  end

  desc 'Backup uploads'
  task :uploads, roles: :db, only: {primary: true} do
    uploads_bkp_path = 'uploads_bkp'
    run "mkdir -p #{uploads_bkp_path}"

    filename = "#{application}_uploads_#{Time.now.strftime('%Y%m%d%H%M')}.zip"
    file_path = File.join(uploads_bkp_path, filename)

    uploads_path = "#{shared_path}/uploads"
    run "zip -r #{file_path} #{uploads_path}"
  end

  desc 'Backup db dump and uploads'
  task :all, roles: :db, only: {primary: true} do 
    dump
    uploads
  end
end