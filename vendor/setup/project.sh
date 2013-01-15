#!/bin/bash

shopt -s nocaseglob
set -e

app_repository="git@github.com:elite-ti/new_elite_app.git"
app_name="new_elite_app"

clear
echo "=> Cloning elite_app repository"
mkdir ~/code && cd ~/code && git clone $app_repository $app_name

clear
echo "=> Installing elite_app dependencies"
sudo apt-get -y install libxslt-dev libxml2-dev imagemagick

clear
echo "=> Installing project gems"
cd $app_name && bundle

clear
echo "=> Setting omniauth for local development"
cp config/initializers/omni_auth.rb.local config/initializers/omni_auth.rb

clear
echo "=> Creating database role"
sudo -u postgres createuser $app_name -P

clear
echo "=> Creating and populating database"
cp config/database.yml.example config/database.yml
rake db:create:all
rake db:populate:all

clear
echo "=> Project setup complete!"
echo "* Set your elite_app postgres user password in config/database.yml"
echo "* Restart your terminal and run cd ~/code/elite_app && rails s"
echo "* Visit localhost:3000 and the app should be running"

exit 0