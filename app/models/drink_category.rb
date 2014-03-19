class DrinkCategory < ActiveRecord::Base

	#########################################
  # Setup accessible (or protected) attributes for your model
  #########################################
  attr_accessible :drink_id, :category_id
  validates_uniqueness_of :drink_id, :scope => :category_id

  #########################################
  # refers to the join
  #########################################
  belongs_to :drink
  belongs_to :category
end
