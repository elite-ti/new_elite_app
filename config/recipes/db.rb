namespace :db do 
  desc 'Populate database'
  task :populate, roles: :db, only: {primary: true} do
    run "cd #{current_path} && bundle exec rake RAILS_ENV=production db:populate:production"
  end
  before 'db:populate', 'bkp:dump'
  before 'db:populate', 'bkp:uploads'
end
