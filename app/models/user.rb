class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable, :invitable

  before_save :ensure_authentication_token

  #validates :name, presence: true
  validates_length_of :name, :maximum => 50
  validates_uniqueness_of :name;

  #########################################
  # Setup accessible (or protected) attributes for your model
  #########################################
  attr_accessible :name, :email, :current_password, :password, :password_confirmation, :remember_me, :photo, :tender, :invitation_token, :invited_by_id, :invited_by_type, :notify, :privateprofile
  attr_accessor :current_password


  #########################################
  # my custom ones
  # this is a list of the associations that any user has (users/4/microposts), @user.microposts
  #########################################

  has_many :microposts, dependent: :destroy
  has_many :micropost_users, dependent: :destroy # tagged in posts, but we don't also have microposts because of the dual name conflict

  has_many :relationships, 
            foreign_key: "follower_id", 
            dependent: :destroy

  has_many :followed_users, 
            -> { where(['relationships.status = ?',"FOLLOWING"] ) },
            through: :relationships, 
            class_name: "User", 
            source: :followed

  has_many :reverse_relationships, 
            foreign_key: "followed_id",
            class_name: "Relationship",
            dependent: :destroy

  has_many :followers, 
            -> { where(['relationships.status = ?',"FOLLOWING"] ) },
            through: :reverse_relationships, 
            class_name: "User", 
            source: :follower 

  has_many :friendrequests, 
            -> { where(['relationships.status = ?',"REQUEST"] ).order('relationships.updated_at DESC') },
            through: :reverse_relationships, 
            class_name: "User", 
            source: :follower 

  #########################################
  # foursquare venues for user, this is different than the others because venues can have more than one user
  #########################################
  #has_and_belongs_to_many :venues, :uniq => true
  has_many :favorites, dependent: :destroy
  has_many :venues,
            -> { order('lower(name) ASC').limit(50) },
            through: :favorites,
            class_name: "Venue",
            source: :venue

  has_many :workfavorites, dependent: :destroy
  has_many :workvenues,
            -> { order('lower(name) ASC').limit(50) },
            through: :workfavorites,
            class_name: "Venue",
            source: :venue

  #########################################
  # drinks
  #########################################
  has_many :user_drinks, dependent: :destroy
  has_many :drinks,
            -> { order('lower(name) ASC').limit(50) },
            :through => :user_drinks,
            class_name: "Drink"
            
  #########################################
  # paperclip profile photo
  #########################################
  has_attached_file :photo, :styles => { :small => "300x300#" },
                            :default_url => 'missing_:style.png'

  #########################################
  # these methods can be called from the controller to get data from other models 
  # look in the controller and see these get called 
  #########################################                       
  
  # status feeds
  def feed
    Micropost.from_users_followed_by(self)
  end

  def feedtender
    Micropost.from_userstender_followed_by(self)
  end

  def followersfeed
    Micropost.from_users_followers(self)
  end
  
  # users following
  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user, status)
    relationships.create!(followed_id: other_user.id, status: status)
  end

  def unfollow!(other_user)
    favorites.find_by_followed_id(other_user.id).destroy
  end

  # venues favoriting
  def favorited?(venue)
    relationships.find_by_venue_id(venue.id)
  end

  def favorite!(venue)
    favorites.create!(venue_id: venue.id)
  end

  def unfavorite!(venue)
    favorites.find_by_venue_id(venue.id).destroy
  end

  # workfavorites
  def workfavorited?(venue)
    workfavorites.find_by_venue_id(venue.id)
  end

  def addworkplace!(venue)
    workfavorites.create!(venue_id: venue.id)
  end

  def removeworkplace!(venue)
    workfavorites.find_by_venue_id(venue.id).destroy
  end

  # profile photos
  def photo_url
    photo.url(:small)
  end

  # search
  def self.search(search)
    order('name ASC').where('lower(name) LIKE ?', "%#{search.downcase}%").limit(50)
  end

  def self.searchbyemail(email)
    where('lower(email) = ?', email.downcase)
  end

  def self.get_drink_users(drink)

    # ordering by number of followers
    select( "DISTINCT users.*, count(relationships.id) AS relationships_count" ).
    where( "users.id IN (SELECT user_id FROM user_drinks WHERE drink_id = :drink_id) AND users.tender = 'YES'", drink_id: drink.id).
    joins( "INNER JOIN relationships ON relationships.followed_id = users.id" ).
    group( "users.id" ).
    order( "relationships_count DESC").
    limit(10)
  end

end

