class AddExamCodeToStudentExam < ActiveRecord::Migration
  def change
    add_column :student_exams, :exam_code, :string
  end
end
