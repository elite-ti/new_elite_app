class AddCodeToExam < ActiveRecord::Migration
  def change
    add_column :exams, :code, :string
  end
end
