class RemoveExamQuetionIdFromExamAnswers < ActiveRecord::Migration
  def up
  	remove_column :exam_answers, :exam_question_id
  end

  def down
  	raise ActiveRecord::IrreversibleMigration, 'Can\'t recover deleted exam_question_ids'
  end
end
