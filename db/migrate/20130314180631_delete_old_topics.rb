class DeleteOldTopics < ActiveRecord::Migration
  def up
		Topic.destroy_all  	
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
