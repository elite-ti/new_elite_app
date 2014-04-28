class RemoveSubjectFromExams < ActiveRecord::Migration
  def up
    remove_column :exams, :subject
  end

  def down
    add_column :exams, :subject, :string
  end
end
