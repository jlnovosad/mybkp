class Workfavorite < ActiveRecord::Base

	#########################################
  # Setup accessible (or protected) attributes for your model
  #########################################
  attr_accessible :user_id, :venue_id
  
  #########################################
  # refers to the join
  #########################################
  belongs_to :user
  belongs_to :venue
end

