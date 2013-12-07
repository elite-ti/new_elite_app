class AddEmployeeIdToCardProcessing < ActiveRecord::Migration
  def change
    add_column :card_processings, :employee_id, :integer
  end
end
