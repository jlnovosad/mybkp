module ApplicationHelper

	#########################################
	# can put custom utility functions here
	#########################################
	def copyright_notice_year
		# Get the current year from the system
		current_year = Time.new.year 
		"#{current_year}"
	end
end
