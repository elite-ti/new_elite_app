class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :ra

      t.timestamps
    end

    add_index 'students', ['ra'], unique: true
    add_index 'students', ['email'], unique: true
  end
end
