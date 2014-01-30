class AddPopularColumnToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :popular, :string
  end
end
