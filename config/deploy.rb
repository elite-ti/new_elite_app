require "bundler/capistrano"
require "sidekiq/capistrano"

load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/postgresql"
load "config/recipes/nodejs"
load "config/recipes/rbenv"
load "config/recipes/check"
load "config/recipes/db"
load "config/recipes/omni_auth"
load "config/recipes/redis"

server "50.116.8.31", :web, :app, :db, primary: true

set :user, "deployer"
set :application, "elite_app"
set :repository, "git@github.com:elite-ti/#{application}.git"

set :google_oauth2_client_id, "941270192118-0meb3qbgdppucv72rfc2g2453c5tnguu.apps.googleusercontent.com"
set :google_oauth2_client_secret, "KxGSxcsiKP-9tLmyjZvhhYBo"

set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup"


namespace :deploy do
  task :cold do
    update
    load_schema
    start
  end

  task :load_schema, roles: :db, only: { primary: true } do
    run "cd #{current_path} && bundle exec rake RAILS_ENV=production db:schema:load"
  end
end

