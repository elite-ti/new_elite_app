# EliteApp

## Todo

* Adicionar funcionalidade de auditoria

* Issues
  * Calendar export button

* Product head teachers
  * can upload cards
  * can view calendars

* Calendario
  * Cada um pode ver os seus

### Tomorrow!

* Calendar
  * create/update/destroy actions for periods

* Fix card processor 
  * Remove parameters from database
  * Product head teachers can upload cards
  * check ability when seeing student exams and exams

* Create holidays and breaks table
  * migrate it!

### Wednesday

* Schedule
  * Update db changes from schema.mwb to schema.rb
  * Create migration script for sample files

## Upload cards flow

* Create an exam cycle which belongs to a product year
* Create an exam in this exam cycle
* Create a student in a klazz which belongs to that product year
* Upload a file setting the same date as set to exam
* Wait until the process is complete
* Check answers


## Setup

Check vendor/setup/readme file.


## Dependencies

* unrar unzip imagemagick libtiff-tools redis libv8-dev


## Database

* Postgresql - db/schema.rb (written in ruby)
* MySQL Workbench - db/schema.mwb


## Tests

* Rspec - Test framework
* Capybara
* Guard


## Deploy

* Linode - Ubuntu 10.04

```sh
ssh root@<host>
adduser deployer --ingroup admin
exit

ssh-copy-id deployer@<host>
cap deploy:install
cap deploy:setup
cap deploy:check
cap deploy:update
cap deploy:load_schema
cap deploy
```


## Tutorials

* Linux - http://nixsrv.com/llthw
* Sublime Text - https://tutsplus.com/course/improve-workflow-in-sublime-text-2/
* railscasts.com, railstutorial.com, destroyallsoftware.com
