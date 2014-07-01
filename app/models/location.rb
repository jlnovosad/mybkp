class Location < ActiveRecord::Base

	attr_accessible :city, :state
  has_many :users

end
