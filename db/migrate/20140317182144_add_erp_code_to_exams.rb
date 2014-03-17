class AddErpCodeToExams < ActiveRecord::Migration
  def change
    add_column :exams, :erp_code, :string
  end
end
