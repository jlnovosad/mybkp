class AddPrivateDefaultToUsers < ActiveRecord::Migration
  def change
  	change_column :users, :privateprofile, :string, :default => "NO"
  end
end
