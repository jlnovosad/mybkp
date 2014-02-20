class CreateTableMicropostUsers < ActiveRecord::Migration
  def change
    create_table :micropost_users do |t|
    	t.integer :micropost_id
      t.integer :user_id

      t.timestamps
    end

    add_index :micropost_users, [:micropost_id, :user_id]
  end
end
