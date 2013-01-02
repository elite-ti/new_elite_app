#!/bin/bash

shopt -s nocaseglob
set -e

name="John Doe"
email="john@doe.com"
ruby_version="1.9.3-p286"

# Run commands
echo "=> Installing Curl and Git"
sudo apt-get update
sudo apt-get -y install curl git-core

clear
echo "=> Setting up Git"
git config --global user.name $name
git config --global user.email $email

clear
echo "=> Installing rbenv"
curl https://raw.github.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash

echo '
export RBENV_ROOT="${HOME}/.rbenv"

if [ -d "${RBENV_ROOT}" ]; then
  export PATH="${RBENV_ROOT}/bin:${PATH}"
  eval "$(rbenv init -)"
fi' >> "$HOME/.bashrc"

export RBENV_ROOT="${HOME}/.rbenv"
if [ -d "${RBENV_ROOT}" ]; then
  export PATH="${RBENV_ROOT}/bin:${PATH}"
  eval "$(rbenv init -)"
fi

rbenv bootstrap-ubuntu-12-04
rbenv install $ruby_version
rbenv global $ruby_version
rbenv bootstrap

clear
echo "=> Updating Rubygems"
gem update --system

clear
echo "=> Installing Node.js"
sudo apt-get -y install python-software-properties
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get -y install nodejs npm

clear
echo "=> Installing Sublime Text"
sudo add-apt-repository -y ppa:webupd8team/sublime-text-2
sudo apt-get update
sudo apt-get -y install sublime-text

clear
echo "=> Installing Google Chrome"
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update
sudo apt-get -y install google-chrome-stable

clear
echo "=> Installing Postgresql"
sudo apt-get -y install libpq-dev postgresql-9.1

clear
echo "=> Creating public key"
echo "* Set default file name (just press enter)"
echo "* Set a passphrase (used to unlock your private key)"
ssh-keygen -t rsa -C $email

clear
echo "=> Environment setup complete!"
echo "* Your public key is (paste it in your GitHub settings accont page):"
cat ~/.ssh/*.pub
echo "* Close this terminal and open another one to access ruby"
echo "* Set your postgres password by running the following commands:"
echo "sudo -u postgres psql"
echo "\password"
echo "<enter your password and its confirmation>"
echo "\q"

exit 0