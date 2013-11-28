class Relationship < ActiveRecord::Base
  
  #########################################
  # Setup accessible (or protected) attributes for your model
  #########################################
  attr_accessible :followed_id, :status

  #########################################
  # refers to the join
  #########################################
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end