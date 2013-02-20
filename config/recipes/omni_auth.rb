namespace :omni_auth do
  desc "Generate the omni_auth.rb configuration file."
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/config/initializers"
    template "omni_auth.rb.erb", "#{shared_path}/config/initializers/omni_auth.rb"
  end
  after "deploy:setup", "omni_auth:setup"

  desc "Symlink the omni_auth.rb file into latest release."
  task :symlink, roles: :app do
    run "ln -nfs #{shared_path}/config/initializers/omni_auth.rb #{release_path}/config/initializers/omni_auth.rb"
  end
  after "deploy:finalize_update", "omni_auth:symlink"
end
