namespace :decompressor do
  desc "Install decompressor on server"
  task :install, roles: :app do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install unzip unrar"
  end
  after "deploy:install", "decompressor:install"
end
