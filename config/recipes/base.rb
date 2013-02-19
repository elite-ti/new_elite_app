def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

namespace :deploy do
  desc "Install everything onto the server"
  task :install do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install python-software-properties"
  end

  desc "Override cold task to load schema instead of migrate"
  task :cold do
    update
    load_schema
    start
  end

  desc "Load schema.rb"
  task :load_schema, roles: :db, only: { primary: true } do
    run "cd #{current_path} && bundle exec rake RAILS_ENV=production db:schema:load"
  end
end
