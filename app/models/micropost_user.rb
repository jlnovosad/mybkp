class MicropostUser < ActiveRecord::Base

	#########################################
  # Setup accessible (or protected) attributes for your model
  #########################################
  attr_accessible :micropost_id, :user_id
  validates_uniqueness_of :micropost_id, :scope => :user_id

  #########################################
  # refers to the join
  #########################################
  belongs_to :micropost
  belongs_to :user
end
