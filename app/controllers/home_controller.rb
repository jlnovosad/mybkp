class HomeController < ApplicationController
  
	#########################################
	# this is only used by the site, for when you login and for the admin user to see a list of users
	#########################################
	def index
		@users = User.all
		@user = current_user
	end
end
