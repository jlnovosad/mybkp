class CreateSpecials < ActiveRecord::Migration
  def change
    create_table :specials do |t|
      t.integer :user_id
      t.integer :venue_id
      
      t.string :content	
      t.string :dayoftheweek	
	  
      t.timestamps
    end
    add_index :specials, [:created_at]
  end
end
