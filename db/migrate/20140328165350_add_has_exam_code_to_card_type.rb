class AddHasExamCodeToCardType < ActiveRecord::Migration
  def change
    add_column :card_types, :has_exam_code, :boolean
  end
end
