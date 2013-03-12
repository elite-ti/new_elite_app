class AddNumberToExamAnswers < ActiveRecord::Migration
  def change
    add_column :exam_answers, :number, :integer
  end
end
