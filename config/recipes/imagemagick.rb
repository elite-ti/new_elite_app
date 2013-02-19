namespace :imagemagick do
  desc "Install imagemagick on server"
  task :install, roles: :app do
    run "#{sudo} apt-get -y install imagemagick"
  end
  after "deploy:install", "imagemagick:install"
end
