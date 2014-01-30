class Renameworkplacestoworkfavorites < ActiveRecord::Migration
  def change
        rename_table :workplaces, :workfavorites
    end 
end
