class DropStylesAndIngredients < ActiveRecord::Migration
  def change
  	drop_table :drink_ingredients
  	drop_table :ingredients
  	drop_table :user_styles
  	drop_table :styles

  	remove_column :favorites, :works
  end
end
