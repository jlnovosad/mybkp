class RenameNotifyColumnInUsers < ActiveRecord::Migration
  def change
  	rename_column :users, :private, :privateprofile
  end
end
