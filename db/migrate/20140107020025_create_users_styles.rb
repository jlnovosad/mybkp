class CreateUsersStyles < ActiveRecord::Migration
  def change
  	drop_table :user_styles

    create_table :users_styles do |t|
    	t.integer :user_id
      t.integer :style_id

      t.timestamps
    end

    add_index :users_styles, [:user_id, :style_id]
  end
end
