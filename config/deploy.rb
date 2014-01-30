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

server '23.92.28.34', :web, :app, :db, primary: true

set :user, 'deployer'
set :application, 'new_elite_app'
set :repository, "git@github.com:elite-ti/#{application}.git"

set :google_oauth2_client_id, '4908308523.apps.googleusercontent.com'
set :google_oauth2_client_secret, 'RfSTUOdYYhNMWCS6UizUcNRj'

set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, 'git'
set :branch, 'pensi'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after 'deploy', 'deploy:cleanup'



        require './config/boot'
        require 'airbrake/capistrano'
