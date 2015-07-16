class Venue < ActiveRecord::Base

	#########################################
	# Setup accessible (or protected) attributes for your model
	#########################################
	attr_accessible :fs_venue_id, :name

	#########################################
	# doesn't allow us to save more than once
	#########################################
	validates_uniqueness_of :fs_venue_id

	#########################################
	# This refers to a join table, users can have many venues and venues can have many users, see the same thing in the other model
	#########################################
	#has_and_belongs_to_many :users, :uniq => true
	has_many :favorites, dependent: :destroy
  has_many :users,
  					#-> { where("privateprofile != 'YES' AND privateprofile != 'INACTIVE'") },
  					-> { where("privateprofile != 'INACTIVE'") },
            :through => :favorites,
            class_name: "User",
            source: :user

  has_many :workfavorites, dependent: :destroy
  has_many :tenders,
  					#-> { where("privateprofile != 'YES' AND privateprofile != 'INACTIVE' AND tender = 'YES'") },
  					-> { where("privateprofile != 'INACTIVE' AND upper(tender) = 'YES'") },
            :through => :workfavorites,
            class_name: "User",
            source: :user
  has_many :checkins
  has_many :shifts

	#########################################
	# these methods can be called from the controller to get data from other models 
	# look in the controller and see these get called 
	#########################################                       
	def feed(user)
		Micropost.from_venue(self, user)
	end

	def workerfeed(user)
		Micropost.from_venue_workers(self, user)
	end
end
