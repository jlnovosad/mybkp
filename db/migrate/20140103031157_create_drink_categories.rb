class CreateDrinkCategories < ActiveRecord::Migration
  def change
    create_table :drink_categories do |t|
    	t.integer :drink_id
      t.integer :category_id

      t.timestamps
    end

    add_index :drink_categories, [:drink_id, :category_id]
  end
end
