class UserDrink < ActiveRecord::Base

	#########################################
  # Setup accessible (or protected) attributes for your model
  #########################################
  attr_accessible :user_id, :drink_id
  validates_uniqueness_of :user_id, :scope => :drink_id
  
  #########################################
  # refers to the join
  #########################################
  belongs_to :user
  belongs_to :drink
end
