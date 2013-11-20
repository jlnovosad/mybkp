class CreateUsersVenuesJoinTable < ActiveRecord::Migration
  def up
  	create_table :users_venues, :id => false do |t|
      t.integer :venue_id
      t.integer :user_id
    end

    add_index :users_venues, [:venue_id, :user_id]
  end

  def down
  	drop_table :users_venues
  end
end
