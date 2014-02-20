class AddNotifyAndPrivateToUser < ActiveRecord::Migration
  def change
    add_column :users, :notify, :string
    add_column :users, :private, :string
  end
end
