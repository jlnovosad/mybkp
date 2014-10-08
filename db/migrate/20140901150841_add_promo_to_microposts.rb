class AddPromoToMicroposts < ActiveRecord::Migration
  def change
  	add_column :microposts, :promo, :string
  end
end
