class AddObservationsToTeacher < ActiveRecord::Migration
  def change
    add_column :teachers, :observations, :text
  end
end
