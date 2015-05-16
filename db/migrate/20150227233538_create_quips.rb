class CreateQuips < ActiveRecord::Migration
  def change
    create_table :quips do |t|
      t.string :content	
	  
      t.timestamps
    end
    add_index :quips, [:created_at]
  end
end
