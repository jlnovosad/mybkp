class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.text :city
      t.text :state
      t.timestamps
    end
    add_column :users, :location_id, :integer
    add_index :locations, [:created_at]
  end
end
