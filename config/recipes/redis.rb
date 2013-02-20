namespace :redis do
  desc "Install redis on server"
  task :install, roles: :app do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install redis-server"
    run "#{sudo} add-apt-repository ppa:rwky/redis"
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y upgrade"
  end
  after "deploy:install", "redis:install"

  %w[start stop restart].each do |command|
    desc "#{command} redis"
    task command, roles: :app do
      run "#{sudo} service redis-server #{command}"
    end
    after "deploy:#{command}", "redis:#{command}"
  end
end
