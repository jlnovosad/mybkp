class Special < ActiveRecord::Base

	attr_accessible :user_id, :venue_id, :content, :dayoftheweek, :location_id
	belongs_to :user
  
end
