class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      t.text :itens
      t.integer :subject_id

      t.timestamps
    end
  end
end
