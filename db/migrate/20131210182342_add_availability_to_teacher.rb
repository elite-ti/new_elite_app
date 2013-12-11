class AddAvailabilityToTeacher < ActiveRecord::Migration
  def change
    add_column :teachers, :availability, :string
  end
end
