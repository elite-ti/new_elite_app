class AddExamDatetimeToExam < ActiveRecord::Migration
  def change
    add_column :exams, :exam_datetime, :datetime
  end
end
