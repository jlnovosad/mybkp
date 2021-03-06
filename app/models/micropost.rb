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
  has_attached_file :photo, :styles => { :small => "640X640#" },
                            :default_url => 'missing_photo.png'

  # Method returns true if file's content type contains word 'image', overwise false
  def is_image_type?
    photo_content_type =~ %r(image)
  end

  # Method returns true if file's content type contains word 'video', overwise false
  def is_video_type?
    photo_content_type =~ %r(video)
  end

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
                          WHERE upper(tender) = 'YES'
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

    # temp location hack fix
    if (user.location_id == 138)
      user.location_id = 1
    end
    if (user.location_id == 165)
      user.location_id = 1
    end

    blocked_user_ids = "SELECT followed_id FROM relationships
                          WHERE follower_id = :user_id
                          AND status = 'BLOCKED'"
    following_user_ids = "SELECT followed_id FROM relationships
                          WHERE follower_id = :user_id
                          AND status = 'FOLLOWING'"                   
    all_user_ids = "SELECT id FROM users
                         WHERE (privateprofile != 'YES' AND privateprofile != 'INACTIVE' AND location_id = :location_id)
                         OR (user_id = :user_id AND privateprofile != 'INACTIVE')
                         OR (user_id IN (#{following_user_ids}) AND privateprofile != 'INACTIVE' AND location_id = :location_id)"
    where("user_id NOT IN (#{blocked_user_ids}) AND user_id IN (#{all_user_ids})", user_id: user.id, location_id: user.location_id)
  end

  # all local activity (public)
  def self.feedlocalpublic(location_id)

    # temp location hack fix
    if (location_id == 138)
      location_id = 1
    end
    if (location_id == 165)
      location_id = 1
    end

    all_user_ids = "SELECT id FROM users
                         WHERE (privateprofile != 'YES' AND privateprofile != 'INACTIVE' AND location_id = :location_id)"
    where("user_id IN (#{all_user_ids})", location_id: location_id)
  end

  # all local activity tenders only
  def self.from_userslocaltenders_followed_by(user)

    # temp location hack fix
    if (user.location_id == 138)
      user.location_id = 1
    end
    if (user.location_id == 165)
      user.location_id = 1
    end

    blocked_user_ids = "SELECT followed_id FROM relationships
                          WHERE follower_id = :user_id
                          AND status = 'BLOCKED'"
    following_user_ids = "SELECT followed_id FROM relationships
                          WHERE follower_id = :user_id
                          AND status = 'FOLLOWING'"                   
    all_user_ids = "SELECT id FROM users
                         WHERE (privateprofile != 'YES' AND privateprofile != 'INACTIVE' AND location_id = :location_id)
                         OR (user_id = :user_id AND privateprofile != 'INACTIVE')
                         OR (user_id IN (#{following_user_ids}) AND privateprofile != 'INACTIVE' AND location_id = :location_id)"
    where("user_id NOT IN (#{blocked_user_ids}) AND user_id IN (#{all_user_ids})", user_id: user.id, location_id: user.location_id)
  end

  # posts from a venue
  def self.from_venue(venue, user)
    #where("user_id NOT IN (#{relationship_user_ids}) AND user_id IN (#{main_user_ids}) AND checkins.venue_id = ?", user_id: venue.id, venue.id)
    #where("checkins.venue_id = ? AND users.privateprofile != ? AND users.privateprofile != ?" , venue.id, "YES", "INACTIVE")
    #where("checkins.venue_id = ? AND users.privateprofile != 'YES' AND users.privateprofile != 'INACTIVE' OR (checkins.venue_id = ? AND users.privateprofile != 'INACTIVE' AND users.id = ?)", venue.id, venue.id, user.id)

    blocked_user_ids = "SELECT followed_id FROM relationships
                          WHERE follower_id = :user_id
                          AND status = 'BLOCKED'"
    following_user_ids = "SELECT followed_id FROM relationships
                          WHERE follower_id = :user_id
                          AND status = 'FOLLOWING'"  
    main_user_ids = "SELECT id FROM users
                          WHERE privateprofile != 'YES'
                          AND privateprofile != 'INACTIVE'"
    where("(microposts.user_id IN (#{following_user_ids}) AND checkins.venue_id = :venue_id) OR (microposts.user_id NOT IN (#{blocked_user_ids}) AND microposts.user_id IN (#{main_user_ids}) AND checkins.venue_id = :venue_id) OR (microposts.user_id = :user_id AND checkins.venue_id = :venue_id)", user_id: user.id, venue_id: venue.id)
  end

  # posts from a venue's tenders
  def self.from_venue_workers(venue, user)
    #where("checkins.venue_id = ? AND checkins.working = 'YES' AND microposts.updated_at >= ? AND users.privateprofile != 'YES' AND users.privateprofile != 'INACTIVE' AND users.tender = 'YES'
    #  OR (users.id = ? AND users.privateprofile != 'INACTIVE' AND users.tender = 'YES' AND checkins.venue_id = ? AND checkins.working = 'YES' AND microposts.updated_at >= ?)", venue.id, Time.now - 8.hours, user.id, venue.id, Time.now - 8.hours)

    blocked_user_ids = "SELECT followed_id FROM relationships
                          WHERE follower_id = :user_id
                          AND status = 'BLOCKED'"
    following_user_ids = "SELECT followed_id FROM relationships
                          WHERE follower_id = :user_id
                          AND status = 'FOLLOWING'"  
    main_user_ids = "SELECT id FROM users
                          WHERE privateprofile != 'YES'
                          AND privateprofile != 'INACTIVE'
                          AND upper(tender) = 'YES'"
    where("(microposts.user_id IN (#{following_user_ids}) AND checkins.venue_id = :venue_id AND checkins.working = 'YES' AND microposts.updated_at >= :recent) OR (microposts.user_id NOT IN (#{blocked_user_ids}) AND microposts.user_id IN (#{main_user_ids}) AND checkins.venue_id = :venue_id AND checkins.working = 'YES' AND microposts.updated_at >= :recent) OR (microposts.user_id = :user_id AND checkins.venue_id = :venue_id AND checkins.working = 'YES' AND microposts.updated_at >= :recent)", user_id: user.id, venue_id: venue.id, recent: Time.now - 8.hours)
  end

  # public posts from a venue
  def self.publicfrom_venue(venue)
    main_user_ids = "SELECT id FROM users
                          WHERE privateprofile != 'YES'
                          AND privateprofile != 'INACTIVE'"
    where("(microposts.user_id IN (#{main_user_ids}) AND checkins.venue_id = :venue_id)", venue_id: venue.id)
  end

  # public posts from a venue's tenders
  def self.publicfrom_venue_workers(venue)
    main_user_ids = "SELECT id FROM users
                          WHERE privateprofile != 'YES'
                          AND privateprofile != 'INACTIVE'
                          AND upper(tender) = 'YES'"
    where("(microposts.user_id IN (#{main_user_ids}) AND checkins.venue_id = :venue_id AND checkins.working = 'YES' AND microposts.updated_at >= :recent)", venue_id: venue.id, recent: Time.now - 8.hours)
  end

  def photo_url
    photo.url(:small)
  end

  def thumb_url
    photo.url(:thumb)
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
  
  # comments only from good users
  def goodcomments
    User.isliked(self)
  end

end