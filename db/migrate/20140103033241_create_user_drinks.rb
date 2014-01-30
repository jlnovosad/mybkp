class CreateUserDrinks < ActiveRecord::Migration
  def change
    create_table :user_drinks do |t|
    	t.integer :user_id
      t.integer :drink_id

      t.timestamps
    end

    add_index :user_drinks, [:user_id, :drink_id]
  end
end
