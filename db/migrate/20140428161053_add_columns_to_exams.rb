class AddColumnsToExams < ActiveRecord::Migration
  def change
    add_column :exams, :erp_code, :string
    add_column :exams, :exam_datetime, :datetime
    add_column :exams, :subjects, :string
  end
end
