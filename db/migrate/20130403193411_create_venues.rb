class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :fs_venue_id

      t.timestamps
    end
    add_index :venues, [:fs_venue_id, :created_at]
  end
end
