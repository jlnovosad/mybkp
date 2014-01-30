class AddPopularColumnToDrinks < ActiveRecord::Migration
  def change
    add_column :drinks, :popular, :string
  end
end
