class AddErpCodeToProductYears < ActiveRecord::Migration
  def change
    add_column :product_years, :erp_code, :string
  end
end
