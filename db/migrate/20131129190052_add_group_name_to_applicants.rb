class AddGroupNameToApplicants < ActiveRecord::Migration
  def change
    add_column :applicants, :group_name, :string
  end
end
