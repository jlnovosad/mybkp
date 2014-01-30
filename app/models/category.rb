class Category < ActiveRecord::Base

	attr_accessible :name, :popular
	validates_uniqueness_of :name
	
	has_many :drink_categories, dependent: :destroy
  has_many :drinks,
  					-> { uniq.limit(50) },
            :through => :drink_categories,
            class_name: "Drink"

  def self.search(search)
    order('name ASC').where('lower(name) LIKE ?', "%#{search.downcase}%").limit(50)
  end

end
