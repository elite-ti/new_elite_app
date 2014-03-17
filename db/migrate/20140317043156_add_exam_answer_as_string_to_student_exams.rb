class AddExamAnswerAsStringToStudentExams < ActiveRecord::Migration
  def change
    add_column :student_exams, :exam_answer_as_string, :string
  end
end
