class Micropost < ActiveRecord::Base
  
  #########################################
  # Setup accessible (or protected) attributes for your model
  #########################################
  attr_accessible :content, :venue_id, :photo, :working, :users, :user_id, :promo
  belongs_to :user
  belongs_to :venue
  attr_accessor :current_user

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
  # included
  #########################################
  has_many :micropost_users, dependent: :destroy
  has_many :users,
            -> { uniq },
            through: :micropost_users,
            class_name: "User"
  has_one :checkin
  has_many :likes
  has_many :comments

  #########################################
  # an actually db query, the controller uses these
  #########################################

  # people you follow
  def self.from_users_followed_by(user)
    relationship_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id
                         AND status = 'FOLLOWING'"
    main_user_ids = "SELECT id FROM users
                          WHERE privateprofile != 'INACTIVE'"
    where("user_id IN (#{relationship_user_ids}) AND user_id IN (#{main_user_ids})", user_id: user.id)
  end

  # tenders you follow
  def self.from_userstender_followed_by(user)
    relationship_user_ids = "SELECT followed_id FROM relationships
                          WHERE follower_id = :user_id
                          AND status = 'FOLLOWING'"
    main_user_ids = "SELECT id FROM users
                          WHERE tender = 'YES'
                          AND privateprofile != 'INACTIVE'"
    where("user_id IN (#{relationship_user_ids}) AND user_id IN (#{main_user_ids})", user_id: user.id)
  end

  # featured tenders and places
  def self.from_userspopular_followed_by(user)
    relationship_user_ids = "SELECT followed_id FROM relationships
                          WHERE follower_id = :user_id
                          AND status = 'BLOCKED'"
    main_user_ids = "SELECT id FROM users
                         WHERE featured = 'YES'
                         AND privateprofile != 'INACTIVE'
                         AND (location_id = :location_id)"
    where("user_id NOT IN (#{relationship_user_ids}) AND user_id IN (#{main_user_ids})", user_id: user.id, location_id: user.location_id)
  end

  # all local activity 
  def self.from_userslocal_followed_by(user)
    relationship_user_ids = "SELECT followed_id FROM relationships
                          WHERE follower_id = :user_id
                          AND status = 'BLOCKED'"
    main_user_ids = "SELECT id FROM users
                         WHERE privateprofile != 'YES'
                         AND privateprofile != 'INACTIVE'
                         AND (location_id = :location_id)
                         OR (user_id = :user_id AND privateprofile != 'INACTIVE')"
    where("user_id NOT IN (#{relationship_user_ids}) AND user_id IN (#{main_user_ids})", user_id: user.id, location_id: user.location_id)
  end

  # posts from a venue
  def self.from_venue(venue, user)
    #where("user_id NOT IN (#{relationship_user_ids}) AND user_id IN (#{main_user_ids}) AND checkins.venue_id = ?", user_id: venue.id, venue.id)
    #where("checkins.venue_id = ? AND users.privateprofile != ? AND users.privateprofile != ?" , venue.id, "YES", "INACTIVE")
    where("checkins.venue_id = ? AND users.privateprofile != 'YES' AND users.privateprofile != 'INACTIVE' OR (checkins.venue_id = ? AND users.privateprofile != 'INACTIVE' AND users.id = ?)", venue.id, venue.id, user.id)
  end

  # posts from a venue's tenders
  def self.from_venue_workers(venue, user)
    where("checkins.venue_id = ? AND checkins.working = 'YES' AND microposts.updated_at >= ? AND users.privateprofile != 'YES' AND users.privateprofile != 'INACTIVE' AND users.tender = 'YES'
      OR (users.id = ? AND users.privateprofile != 'INACTIVE' AND users.tender = 'YES' AND checkins.venue_id = ? AND checkins.working = 'YES' AND microposts.updated_at >= ?)", venue.id, Time.now - 8.hours, user.id, venue.id, Time.now - 8.hours)
  end

  def photo_url
    photo.url(:small)
  end

  def like_count
    likes.count
  end

  def comment_count
    comments.count
  end

  def isliked
    User.isliked(self)
  end

end