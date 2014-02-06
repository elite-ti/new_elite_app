class AddKlazzIdToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :klazz_id, :integer
  end
end
