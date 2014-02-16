class AddGradesToStudentExam < ActiveRecord::Migration
  def change
    add_column :student_exams, :grades, :string
  end
end
