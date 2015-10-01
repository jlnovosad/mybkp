class AddNotifyToRelationship < ActiveRecord::Migration
  def change
    add_column :relationships, :notify, :string
  end
end
