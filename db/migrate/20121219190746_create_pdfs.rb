class CreatePdfs < ActiveRecord::Migration
  def change
    create_table :pdfs do |t|
      t.integer :klazz_id
      t.integer :poll_id

      t.timestamps
    end
  end
end
