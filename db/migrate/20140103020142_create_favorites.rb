class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :venue_id
      t.string :works

      t.timestamps
    end

    add_index :favorites, [:user_id, :venue_id]

    # finally, dump the old hatbm associations
  	drop_table :users_venues
  end
end
