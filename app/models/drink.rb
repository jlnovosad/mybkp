class Drink < ActiveRecord::Base

	attr_accessible :name, :popular, :user_id
  validates_uniqueness_of :name

	has_many :drink_categories, dependent: :destroy
  has_many :categories,
            -> { uniq.limit(50).order(:name) },
            :through => :drink_categories,
            class_name: "Category"

  has_many :drink_ingredients, dependent: :destroy
  has_many :ingredients,
            -> { uniq.limit(50) },
            :through => :drink_ingredients,
            class_name: "Ingredient"

  has_many :user_drinks, dependent: :destroy
  has_many :users,
            -> { where(['tender = ?',"YES"]).uniq.limit(50) },
            :through => :user_drinks,
            class_name: "User"
            #-> { where(['tender = ?',"NO"]).uniq.order("users.followers_count DESC").limit(50) },

  def self.search(search)
    order('name ASC').where('lower(name) LIKE ?', "%#{search.downcase}%").limit(50)
  end

  def drinkusers
    User.get_drink_users(self)
  end

end
