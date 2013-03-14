class CreateSuperExams < ActiveRecord::Migration
  def change
    create_table :super_exams do |t|

      t.timestamps
    end
  end
end
