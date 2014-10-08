class DropActiveFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :active
  end
end
