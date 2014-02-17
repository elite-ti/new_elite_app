class AddErpCodeToEnrollment < ActiveRecord::Migration
  def change
    add_column :enrollments, :erp_code, :string
  end
end
