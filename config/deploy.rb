require 'bundler/capistrano'
require 'sidekiq/capistrano'

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
set :branch, 'master'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after 'deploy', 'deploy:cleanup'


