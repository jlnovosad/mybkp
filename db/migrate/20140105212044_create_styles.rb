class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
    	t.string :name
    	t.string :popular

      t.timestamps
    end

    add_index :styles, [:created_at]
  end
end
