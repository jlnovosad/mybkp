class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable, :invitable

  before_save :ensure_authentication_token

  validates :name, presence: true
  validates_length_of :name, :minimum => 1, :maximum => 50

  #########################################
  # Setup accessible (or protected) attributes for your model
  #########################################
  attr_accessible :name, :email, :current_password, :password, :password_confirmation, :remember_me, :photo, :tender, :invitation_token, :invited_by_id, :invited_by_type
  attr_accessor :current_password


  #########################################
  # my custom ones
  # this is a list of the associations that any user has (users/4/microposts), @user.microposts
  #########################################
  has_many :microposts, dependent: :destroy
  
  has_many :relationships, 
            foreign_key: "follower_id", 
            dependent: :destroy
  has_many :followed_users, 
            through: :relationships, 
            class_name: "User", 
            source: :followed,
            :conditions => ['relationships.status = ?',"FOLLOWING"]

  has_many :reverse_relationships, 
            foreign_key: "followed_id",
            class_name: "Relationship",
            dependent: :destroy,
            :conditions => ['relationships.status = ?',"FOLLOWING"] 
  has_many :followers, 
            through: :reverse_relationships, 
            class_name: "User", 
            source: :follower,
            :conditions => ['relationships.status = ?',"FOLLOWING"]                      

  has_many :friend_requests, 
            :through => :reverse_relationships, 
            :class_name => "User", 
            :source => :follower, 
            :conditions => ['relationships.status = ?',"REQUEST"]

  #########################################
  # foursquare venues for user, this is different than the others because venues can have more than one user
  #########################################
  has_and_belongs_to_many :venues, :uniq => true

  #########################################
  # paperclip profile photo
  #########################################
  has_attached_file :photo, :styles => { :small => "300x300#" },
                            :default_url => 'missing_:style.png'

  #########################################
  # these methods can be called from the controller to get data from other models 
  # look in the controller and see these get called 
  #########################################                       
  def feed
    Micropost.from_users_followed_by(self)
  end

  def feedtender
    Micropost.from_userstender_followed_by(self)
  end

  def followersfeed
    Micropost.from_users_followers(self)
  end
  
  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user, status)
    relationships.create!(followed_id: other_user.id, status: status)
  end

  #def unfollow!(other_user)
  #  relationships.find_by_followed_id(other_user.id).destroy
  #end

  def photo_url
    photo.url(:small)
  end

  def self.search(search)
    
    #search_condition = "%" + search.downcase + "%"
    #where("'name ILIKE ?', search_condition", :limit => 50, :order => "name ASC")
    #find(:all, :conditions => ['name ILIKE ?', search_condition], :limit => 50, :order => "name ASC")

    order('name ASC').where('lower(name) LIKE ?', "%#{search.downcase}%").limit(50)

  end

  def self.searchbyemail(email)
    where('lower(email) = ?', email.downcase).limit(50)
  end

end
