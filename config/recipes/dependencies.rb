namespace :nodejs do
  desc "Install the latest relase of Node.js"
  task :install, roles: :app do
    run "#{sudo} add-apt-repository ppa:chris-lea/node.js"
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install nodejs"
  end
  after "deploy:install", "nodejs:install"
end

namespace :imagemagick do
  desc "Install imagemagick on server"
  task :install, roles: :app do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install imagemagick"
  end
  after "deploy:install", "imagemagick:install"
end

namespace :zip do
  desc "Install zip on server"
  task :install, roles: :app do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install zip unzip"
  end
  after "deploy:install", "zip:install"
end

namespace :rar do
  desc "Install rar on server"
  task :install, roles: :app do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install rar unrar"
  end
  after "deploy:install", "rar:install"
end