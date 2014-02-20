class CreateMicropostUsers < ActiveRecord::Migration
  def change
  	drop_table :micropost_users
  	
    create_table :micropost_users do |t|

      t.timestamps
    end
  end
end
