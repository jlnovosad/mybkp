class Checkin < ActiveRecord::Base

	#########################################
  # Setup accessible (or protected) attributes for your model
  #########################################
  attr_accessible :working, :micropost_id, :user_id, :venue_id
  belongs_to :micropost
  belongs_to :user
  belongs_to :venue

end
