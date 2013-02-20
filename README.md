# EliteApp

## Todo

* Adicionar funcionalidade de auditoria
* Create staging environment and deploy daily
* Add dpi validation to card upload

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



## Database

* Postgresql - db/schema.rb 
* MySQL Workbench - db/schema.mwb
* Populate tasks - lib/tasks/populate/
