require 'bundler/capistrano'
require 'sidekiq/capistrano'

set :whenever_command, "bundle exec whenever"
require 'whenever/capistrano'

load 'config/recipes/base'
load 'config/recipes/check'
load 'config/recipes/rbenv'
load 'config/recipes/nginx'
load 'config/recipes/unicorn'
load 'config/recipes/postgresql'
load 'config/recipes/redis'
load 'config/recipes/omni_auth'
load 'config/recipes/dependencies'
load 'config/recipes/db'
load 'config/recipes/card_scanner'
load 'config/recipes/carrierwave'
load 'config/recipes/bkp'

server '50.116.8.31', :web, :app, :db, primary: true

set :user, 'deployer'
set :application, 'new_elite_app'
set :repository, "git@github.com:elite-ti/#{application}.git"

set :google_oauth2_client_id, '941270192118-0meb3qbgdppucv72rfc2g2453c5tnguu.apps.googleusercontent.com'
set :google_oauth2_client_secret, 'KxGSxcsiKP-9tLmyjZvhhYBo'

set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, 'git'
set :branch, 'production'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after 'deploy', 'deploy:cleanup'

require './config/boot'
require 'airbrake/capistrano'

namespace :deploy do
  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
      from = source.next_revision(current_revision)
      if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
        run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
    end
  end
end