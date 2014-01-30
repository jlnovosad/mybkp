class CreateWorkplaces < ActiveRecord::Migration
  def change
    create_table :workplaces do |t|
    	t.integer :user_id
      t.integer :venue_id

      t.timestamps
    end

    add_index :workplaces, [:user_id, :venue_id]
    
  end
end
