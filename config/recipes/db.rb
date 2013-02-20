set_default(:remote_user) { application }
set_default(:remote_db) { "#{application}_production" }
set_default(:local_db) { "#{application}_development" }

namespace :db do
  desc "Push development database to production"
  task :push, roles: :db, only: {primary: true} do
    # unicorn.stop
    # nginx.stop

    # system "sudo -u postgres pg_dump #{local_db} >> /tmp/dump.sql;"
    # upload "/tmp/dump.sql", "/home/#{user}/dump.sql", via: :scp
    # system "rm /tmp/dump.sql;"

    # run %Q{#{sudo} -u postgres psql -c "drop database #{remote_db};"}
    # run %Q{#{sudo} -u postgres psql -c "create database #{remote_db} owner #{remote_user};"}
    # run %Q{#{sudo} -u postgres psql #{remote_db} < /home/#{user}/dump.sql;}
    # run %Q{rm /home/#{user}/dump.sql;}

    # nginx.start
    # unicorn.start
  end

  desc "Populate database"
  task :populate, roles: :db, only: {primary: true} do
    # unicorn.stop
    # nginx.stop
    # run "cd #{current_path} && bundle exec rake RAILS_ENV=production db:populate:all"
    # nginx.start
    # unicorn.start
  end
end
