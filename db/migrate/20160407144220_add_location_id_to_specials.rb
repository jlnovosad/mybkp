class AddLocationIdToSpecials < ActiveRecord::Migration
  def change
    add_column :specials, :location_id, :integer
  end
end
