class Device < ActiveRecord::Base

	#########################################
	# Setup accessible (or protected) attributes for your model
	#########################################
	attr_accessible :token, :user_id

	#########################################
	# doesn't allow us to save more than once
	#########################################
	validates_uniqueness_of :token

	#########################################
	# This refers to a join table
	#########################################
	belongs_to :user
end
