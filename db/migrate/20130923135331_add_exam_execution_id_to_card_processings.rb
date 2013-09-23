class AddExamExecutionIdToCardProcessings < ActiveRecord::Migration
  def change
    add_column :card_processings, :exam_execution_id, :integer
  end
end
