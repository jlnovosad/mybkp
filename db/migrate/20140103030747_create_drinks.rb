class CreateDrinks < ActiveRecord::Migration
  def change
    create_table :drinks do |t|
    	t.string :name

      t.timestamps
    end

    add_index :drinks, [:created_at]
  end
end
