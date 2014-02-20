class AddMicrpostIdAndUserIdToMicropostUsers < ActiveRecord::Migration
  def change
  	add_column :micropost_users, :micropost_id, :integer
  	add_column :micropost_users, :user_id, :integer

  	add_index :micropost_users, [:micropost_id]
  	add_index :micropost_users, [:user_id]
  end
end
