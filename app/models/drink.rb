class Drink < ActiveRecord::Base

	attr_accessible :name, :popular, :user_id, :photo
  #validates :name, :uniqueness => { :case_sensitive => false }

	has_many :drink_categories, dependent: :destroy
  has_many :categories,
            -> { order('lower(name) ASC') },
            :through => :drink_categories,
            class_name: "Category"

  has_many :user_drinks, dependent: :destroy
  has_many :users,
            -> { where(['upper(tender) = ? AND privateprofile != ?',"YES","INACTIVE"]).order('lower(name) ASC')},
            :through => :user_drinks,
            class_name: "User"
            #-> { where(['tender = ?',"NO"]).uniq.order("users.followers_count DESC").limit(50) },

  has_attached_file :photo, :styles => { :small => "640x480#" },
                            :default_url => 'missing_drink.png'

  def self.search(search)
    order('name ASC').where('lower(name) LIKE ?', "%#{search.downcase}%").limit(50)
  end

  def drinkusers
    User.get_drink_users(self)
  end

  def photo_url
    photo.url(:small)
  end
end
