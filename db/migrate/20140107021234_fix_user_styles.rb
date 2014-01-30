class FixUserStyles < ActiveRecord::Migration
  def change
  	drop_table :users_styles

    create_table :user_styles do |t|
    	t.integer :user_id
      t.integer :style_id

      t.timestamps
    end

    add_index :user_styles, [:user_id, :style_id]
  end
end
