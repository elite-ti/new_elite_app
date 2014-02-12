class AddFullNameToExamExecution < ActiveRecord::Migration
  def change
    add_column :exam_executions, :full_name, :string
  end
end
