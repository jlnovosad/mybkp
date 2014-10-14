class Comment < ActiveRecord::Base

	#########################################
  # Setup accessible (or protected) attributes for your model
  #########################################
  attr_accessible :content, :micropost_id, :user_id
  belongs_to :micropost
  belongs_to :user
  default_scope order: 'comments.created_at DESC'
end
