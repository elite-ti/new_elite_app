class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :pdf_id
      t.integer :question_type_id
      t.integer :question_category_id
      t.integer :teacher_id
      t.integer :number

      t.timestamps
    end
  end
end
