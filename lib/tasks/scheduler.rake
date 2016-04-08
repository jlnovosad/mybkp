desc "This task is called by the Heroku scheduler add-on"

require 'csv'

task :update_feed => :environment do
  puts "Updating feed..."
end

task :update_happyhr => :environment do
  puts "Updating happyhr..."

  # today
  time = Time.now
  @d = time.strftime("%^a") #SUN,MON etc
  puts @d

  # which cities (location ids)
  #@locations = [1]

  # for each city
  #@locations.each do |l|

	  @myspecial = Special.where("dayoftheweek = ? AND location_id = ?", @d, 1).sample
	  @mypeep = User.find(@myspecial.user_id)
	  @myvenue = Venue.find(@myspecial.venue_id)
	  @m = Micropost.create!(content: @myspecial.content, user_id:@mypeep.id)
		@c = Checkin.create!(micropost_id: @m.id, user_id:@mypeep.id, venue_id: @myvenue.id)

	#end
  
end

task :update_activity => :environment do
  puts "Updating activity..."
  
  # which cities (location ids)
  @locations = [1,165]

  # for each city
  @locations.each do |l|
  
  	# insert random here, will do this task every 10 min, sometimes you wont do anything
    case rand(100) + 1
    when  1..25 
    	puts "WITH CHECK"
    	# users with venue checkin
	    @mypeep = User.where("venueprofile = ? AND location_id = ?", "HELPER", l).sample
	    @myquip = Quip.all.sample
	    @myvenue = @mypeep.checkfavorites.sample
	    @m = Micropost.create!(content: @myquip.content, user_id:@mypeep.id)
	    @c = Checkin.create!(micropost_id: @m.id, user_id:@mypeep.id, venue_id: @myvenue.id)

    when 56..50  
    	puts "WITHOUT CHECK"
	    # users with no checkin
	    @mypeep = User.where("venueprofile = ? AND location_id = ?", "HELPER", l).sample
	    @myquip = Quip.all.sample
	    @m = Micropost.create!(content: @myquip.content, user_id:@mypeep.id)

    when 51..100 
    	puts "NOTHING"
    	# nothing

    else
    	puts "ELSE"
    end
    
    

    
    
  end

end


