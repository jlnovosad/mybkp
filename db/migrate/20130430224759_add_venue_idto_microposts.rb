class AddVenueIdtoMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :venue_id, :integer
  end
end
