class Like < ActiveRecord::Base

	#########################################
  # Setup accessible (or protected) attributes for your model
  #########################################
  attr_accessible :micropost_id, :user_id
  belongs_to :micropost
  belongs_to :user

end
