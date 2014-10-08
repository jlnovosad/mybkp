class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
    	t.string :working
      t.integer :micropost_id
      t.integer :user_id
      t.integer :venue_id

      t.timestamps
    end
    add_index :checkins, [:micropost_id, :created_at]
    add_index :checkins, [:user_id, :created_at]
    add_index :checkins, [:venue_id, :created_at]
  end
end
