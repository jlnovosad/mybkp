class AddWorkingToMicroposts < ActiveRecord::Migration
  def change
  	add_column :microposts, :working, :string
  end
end
