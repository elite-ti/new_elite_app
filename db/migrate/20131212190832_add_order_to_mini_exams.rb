class AddOrderToMiniExams < ActiveRecord::Migration
  def change
    add_column :mini_exams, :order, :integer
  end
end
