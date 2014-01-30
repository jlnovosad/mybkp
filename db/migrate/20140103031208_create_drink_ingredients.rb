class CreateDrinkIngredients < ActiveRecord::Migration
  def change
    create_table :drink_ingredients do |t|
    	t.integer :drink_id
      t.integer :ingredient_id
      t.string :amount

      t.timestamps
    end

    add_index :drink_ingredients, [:drink_id, :ingredient_id]
  end
end
