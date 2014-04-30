class AddVenueprofileToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :venueprofile, :string
  end
end
