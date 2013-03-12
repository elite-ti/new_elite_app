class AddSubjectIdToExams < ActiveRecord::Migration
  def change
    add_column :exams, :subject_id, :integer
  end
end
