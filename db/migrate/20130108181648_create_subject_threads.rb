class CreateSubjectThreads < ActiveRecord::Migration
  def change
    create_table :subject_threads do |t|
      t.integer :subject_id
      t.integer :year_id
      t.string :name

      t.timestamps
    end

    add_index 'subject_threads', ['subject_id', 'year_id', 'name'], unique: true
  end
end
