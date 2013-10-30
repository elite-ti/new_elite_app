class AddHasTabletToTeacher < ActiveRecord::Migration
  def change
    add_column :teachers, :has_tablet, :boolean
  end
end
