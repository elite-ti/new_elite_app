class AddErpCodeToCampus < ActiveRecord::Migration
  def change
    add_column :campuses, :erp_code, :string
  end
end
