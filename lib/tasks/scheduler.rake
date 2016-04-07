desc "This task is called by the Heroku scheduler add-on"

require 'csv'

task :update_feed => :environment do
  puts "Updating feed..."
end

task :populate_activity => :environment do
  puts "Populating..."

	csv = CSV.read('lib/tasks/d_quip.csv', :headers => true, :encoding => 'iso-8859-1:utf-8')
  csv.each_with_index do |row, index|
    Quip.create!(:content => row['content'])
  end

  scsv = CSV.read('lib/tasks/d_special.csv', :headers => true, :encoding => 'iso-8859-1:utf-8')
  scsv.each_with_index do |row, index|
    Special.create!(:content => row['content'], :dayoftheweek => row['dayoftheweek'], :user_id => row["user_id"], :venue_id => row["venue_id"], :location_id => row["location_id"])
  end

end

task :populate_favorites => :environment do
  puts "Populating..."

  @users = User.where("venueprofile = ? AND location_id = ?", "HELPER", 1)
  @favs = User.find(1).favorites
  @users.each do |u|
  	(1..10).each do |p| 
  		@venue = Venue.offset(rand(@favs.count)).first
  		u.checkfavorite!(@venue)
		end
  end

end

task :update_happyhr => :environment do
  puts "Updating happyhr..."

  # today
  time = Time.now
  @d = time.strftime("%^a") #SUN,MON etc
  
  # which cities (location ids)
  @locations = Array.new(1)

  # for each city
  @locations.each do |l|

	  # happy hr
	  #@myspecial = Special.offset(rand(Special.where("dayoftheweek = ? AND location_id = ?", @d, l).count)).first
	  puts @d
	  puts l

	  @myspecial = Special.where("dayoftheweek = ? AND location_id = ?", @d, l).sample
	  
puts @myspecial.content

	  @mypeep = User.find(@myspecial.user_id)
	  @myvenue = Venue.find(@myspecial.venue_id)
	  @m = Micropost.create!(content: @myspecial.content, user_id:@mypeep.id)
		@c = Checkin.create!(micropost_id: @m.id, user_id:@mypeep.id, venue_id: @myvenue.id)

	end
  
end

task :update_activity => :environment do
  puts "Updating activity..."
  
  # which cities (location ids)
  @locations = Array.new(1,165)

  # for each city
  @locations.each do |l|
  
    # insert random here, will do this task every 10 min, sometimes you wont do anything
    case rand(100) + 1
    when  1..50   
    when 50..75   
    when 75..100  
    else
    end
    
    # users with venue checkin
    @mypeep = User.offset(rand(User.where("venueprofile = ? AND location_id = ?", "HELPER", l).count)).first
    @myquip = Quip.offset(rand(Quip.count)).first
    @myvenue = Venue.offset(rand(@mypeep.checkfavorites.count)).first
    @m = Micropost.create!(content: @myquip.content, user_id:@mypeep.id)
    @c = Checkin.create!(micropost_id: @m.id, user_id:@mypeep.id, venue_id: @myvenue.id)

    # users with no checkin
    @mypeep = User.offset(rand(User.where("venueprofile = ? AND location_id = ?", "HELPER", l).count)).first
    @myquip = Quip.offset(rand(Quip.count)).first
    @m = Micropost.create!(content: @myquip.content, user_id:@mypeep.id)
    
  end

end


