class CreateCheckfavorites < ActiveRecord::Migration
  def change
    create_table :checkfavorites do |t|
    	t.integer :user_id
      t.integer :venue_id

      t.timestamps
    end

    add_index :checkfavorites, [:user_id, :venue_id]
  end
end