class AddIndexes < ActiveRecord::Migration
  def up
    add_index :exam_answers, :exam_question_id
    add_index :exam_answers, :student_exam_id
  end

  def down
    remove_index :exam_answers, :exam_question_id
    remove_index :exam_answers, :student_exam_id
  end
end
