class CreateOperators < ActiveRecord::Migration
  def change
    create_table :operators do |t|
      t.integer :employee_id
    end
  end
end
