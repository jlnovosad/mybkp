class Micropost < ActiveRecord::Base
  
  #########################################
  # Setup accessible (or protected) attributes for your model
  #########################################
  attr_accessible :content, :venue_id, :photo, :working, :users, :user_id
  belongs_to :user
  belongs_to :venue

  #########################################
  # I dont have validates set up for all my things, perhaps i do?
  #########################################
  validates :user_id, presence: true
  validates :content, length: { maximum: 300 }
  default_scope order: 'microposts.created_at DESC'

  #########################################
  # paperclip photos
  #########################################
  has_attached_file :photo, :styles => { :small => "640x640#" },
                            :default_url => 'missing_photo.png'

  #########################################
  # tag users
  #########################################
  has_many :micropost_users, dependent: :destroy
  has_many :users,
            -> { uniq },
            :through => :micropost_users,
            class_name: "User"

  #########################################
  # an actually db query, the controller uses these
  #########################################
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id
                         AND status = 'FOLLOWING'"
    venue_user_ids = "SELECT id FROM users
                         WHERE venueprofile = 'YES'
                         AND (location_id = :location_id)"
    where("user_id IN (#{venue_user_ids}) OR (user_id IN (#{followed_user_ids}) OR user_id = :user_id)", user_id: user.id, location_id: user.location_id)
  end

  def self.from_userstender_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                          WHERE follower_id = :user_id
                          AND status = 'FOLLOWING'"
    tender_user_ids = "SELECT id FROM users
                          WHERE tender = 'YES'"
    where("user_id IN (#{followed_user_ids}) AND user_id IN (#{tender_user_ids})", user_id: user.id)
  end

  def self.from_userspopular_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id
                         AND status = 'FOLLOWING'"
    venue_user_ids = "SELECT id FROM users
                         WHERE venueprofile = 'YES'
                         AND (location_id = :location_id)"
    where("user_id IN (#{venue_user_ids}) OR (user_id IN (#{followed_user_ids}) OR user_id = :user_id)", user_id: user.id, location_id: user.location_id)
  end

  def self.from_users_followers(user)
    followers_user_ids = "SELECT follower_id FROM relationships
                         WHERE followed_id = :user_id
                         AND status = 'FOLLOWING'"
    where("user_id IN (#{followers_user_ids})", user_id: user.id)
  end

  def self.from_venue(venue)
    where("venue_id = ? AND users.privateprofile != ?", venue.id, "YES")
  end

  def self.from_venue_workers(venue)
    where("venue_id = ? AND working = ? AND microposts.updated_at >= ? AND users.privateprofile != ?", venue.id, "YES", Time.now - 8.hours, "YES")
  end

  def photo_url
    photo.url(:small)
  end
end