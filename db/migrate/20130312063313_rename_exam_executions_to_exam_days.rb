class RenameExamExecutionsToExamDays < ActiveRecord::Migration
  def up
  	rename_table :exam_executions, :exam_days
  	rename_column :student_exams, :exam_execution_id, :exam_day_id
  end

  def down
  	rename_table :exam_days, :exam_executions
  	rename_column :student_exams, :exam_day_id, :exam_execution_id
  end
end
