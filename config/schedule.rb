# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
set :output, "#{path}/log/cron.log"

every :day, at: "0:00 AM" do
	command "pg_dump -h localhost -U new_elite_app new_elite_app_production -f /home/deployer/dumps_bkp/new_elite_app_production_`date  +'\%Y\%m\%d_\%H\%M'`.sql"
end

every :day, at: "0:00 AM" do
	command "rm /home/deployer/dumps_bkp/new_elite_app_production_`date -d yesterday +'\%Y\%m\%d_\%H\%M'`.sql"
end

every :monday, at: "0:01 AM" do
	command "pg_dump -h localhost -U new_elite_app new_elite_app_production -f /home/deployer/dumps_bkp/new_elite_app_production_`date  +'\%Y\%m\%d_\%H\%M'`.sql"
end

every :monday, at: "0:01 AM" do
	command "rm /home/deployer/dumps_bkp/new_elite_app_production_`date -d 'last week' +'\%Y\%m\%d_\%H\%M'`.sql"
end

every :month, at: "0:02 AM" do
	command "pg_dump -h localhost -U new_elite_app new_elite_app_production -f /home/deployer/dumps_bkp/new_elite_app_production_`date  +'\%Y\%m\%d_\%H\%M'`.sql"
end

every :month, at: "0:02 AM" do
	command "rm /home/deployer/dumps_bkp/new_elite_app_production_`date -d 'last month' +'\%Y\%m'``date +'\%d_\%H\%M'`.sql"
end

every :day, at: "0:18 AM" do
	rake 'backup:student_exams'
end

every :day, at: "0:03 AM" do
	rake 'backup:card_proc'
end

every :day, at: "1:00 AM" do
	rake 'student:sync_applicants'
end
