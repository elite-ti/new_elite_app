class AddWantedWorkloadToTeacher < ActiveRecord::Migration
  def change
    add_column :teachers, :wanted_workload, :integer
  end
end
