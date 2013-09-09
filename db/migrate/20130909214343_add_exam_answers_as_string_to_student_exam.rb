class AddExamAnswersAsStringToStudentExam < ActiveRecord::Migration
  def change
    add_column :student_exams, :exam_answers_as_string, :string
  end
end
