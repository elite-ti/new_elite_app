class CreateExamCycles < ActiveRecord::Migration
  def change
    create_table :exam_cycles do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :end_date
      t.integer :year_id

      t.timestamps
    end

    add_index 'exam_cycles', ['name', 'year_id'], unique: true
  end
end
