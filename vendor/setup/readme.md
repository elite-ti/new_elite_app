# Setup environment

Follow the 7 steps below. 
Any questions or bugs? gustavo.schmidt@sistemaeliterio.com.br

## Setup OS

* Install virtualbox and ubuntu 12.04.1
* Install updates 
    ** Ubuntu Update Manager
* Install guest additions 
    ** Menu > Devices > Install Guest Additions...
* Take a snapshot with the virtual machine turned off
    ** in case something goes wrong
* Copy this setup folder to your Home Folder


## Customize environment.sh

* Change your name and email


## Run environment.sh

* Run the script `bash setup/environment.sh`
* During the installation, you have to:
  ** set your ssh key filename (just press enter to use default) 
  ** set your passphrase to unlock your private key
* This step could take a few minutes


## Set your postgres root user password

* `sudo -u postgres psql`
* `\password`
* <type your password and its confirmation>
* `\q`


## Copy your public key to your GitHub account

* The script above will create a public key for you
* Run `cat ~/.ssh/id_rsa.pub` to print the file content in your terminal
* Copy the whole file content (including ssh-rsa and your email) 
* Paste in your GitHub Account Settings > SSH Keys page


## Restart your terminal window

* This way ruby and rubygems will be available for you
* Check using the following commands:
  ** `ruby -v`
  ** `gem -v`


## Run project.sh

* Run the script `bash setup/project.sh`
* Restart your terminal window and check if rails is available
  ** `rails -v`
* Set your elite_app postgres user password in config/database.yml
* Run 
  ** `cd code/elite_app`
  ** `rails s`
* Visit localhost:3000 and the app should be running