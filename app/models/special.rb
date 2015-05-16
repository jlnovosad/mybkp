class Special < ActiveRecord::Base

	attr_accessible :user_id, :venue_id, :content, :dayoftheweek
	belongs_to :user
  
end
