namespace :card_scanner do
  desc "Install libtiff on server"
  task :install_dependencies, roles: :app do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install libtiff4-dev"
  end
  after "deploy:install", "card_scanner:install_dependencies"
  
  desc "Compile card scanner"
  task :compile, roles: :app do
    run "ruby #{release_path}/lib/card_scanner/type_b/compile.rb"
  end
  after "deploy:finalize_update", "card_scanner:compile"
end