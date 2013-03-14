class CreateExamComponents < ActiveRecord::Migration
  def change
    create_table :exam_components do |t|
      t.integer :super_exam_id
      t.integer :exam_id

      t.timestamps
    end
  end
end
