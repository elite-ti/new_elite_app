class AddSubjectsToExam < ActiveRecord::Migration
  def change
    add_column :exams, :subjects, :string
  end
end
