class CreateMiniExams < ActiveRecord::Migration
  def change
    create_table :mini_exams do |t|
      t.integer :exam_id
      t.integer :subject_id
      t.integer :options_per_question
      t.string :correct_answers

      t.timestamps
    end
  end
end
