class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.integer :student_id
      t.integer :klazz_id

      t.timestamps
    end

    add_index 'enrollments', ['student_id', 'klazz_id'], unique: true
  end
end
