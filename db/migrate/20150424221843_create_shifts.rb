class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
    	t.integer :user_id
    	t.integer :venue_id
      
      t.time :starttime
      t.time :endtime
      t.string :day
      t.string :frequency
      t.string :shifttype
      t.string :social
      t.string :content

      t.timestamps
    end

    add_index :shifts, [:user_id, :venue_id]

  end
end
