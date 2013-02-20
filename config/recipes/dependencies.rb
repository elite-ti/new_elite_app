namespace :imagemagick do
  desc "Install imagemagick on server"
  task :install, roles: :app do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install imagemagick"
  end
  after "deploy:install", "imagemagick:install"
end

namespace :unzip do
  desc "Install unzip on server"
  task :install, roles: :app do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install unzip"
  end
  after "deploy:install", "unzip:install"
end

namespace :unrar do
  desc "Install unrar on server"
  task :install, roles: :app do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install unrar"
  end
  after "deploy:install", "unrar:install"
end

namespace :libtiff do
  desc "Install libtiff on server"
  task :install, roles: :app do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install libtiff-tools"
  end
  after "deploy:install", "libtiff:install"
end