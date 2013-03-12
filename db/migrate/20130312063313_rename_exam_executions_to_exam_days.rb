class RenameExamExecutionsToExamDays < ActiveRecord::Migration
  def up
  	rename_table :exam_days, :exam_days
  end

  def down
  	rename_table :exam_days, :exam_days
  end
end
