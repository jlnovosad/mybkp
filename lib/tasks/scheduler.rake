desc "This task is called by the Heroku scheduler add-on"

task :update_feed => :environment do
  puts "Updating feed..."
end

task :make_users => :environment do
  puts "Updating users..."

  require 'csv'
	require 'User'

	puts Dir.pwd

	photos = Dir.entries("lib/tasks/photosm/")
	csv = CSV.read('lib/tasks/usermen.csv', :headers => true, :encoding => 'iso-8859-1:utf-8')
	csv.each_with_index do |row, index|
	  dynemail = "hbkbatch01m_" + index.to_s + "@heybarkeep.co"
	  puts dynemail
	  puts photos[index]
	  next if photos[index] == '.' or photos[index] == '..'

	  filepath = "lib/tasks/photosm/" + photos[index]
	  puts filepath
	  thisphoto = File.open(filepath)

	  auser = User.create!(:name => row['name'], :email => dynemail, :password => "hbkactivity", :password_confirmation => "hbkactivity", :venueprofile => row['testprofile'], :location_id => row['location_id'], :tender => row['tender'])

	  if auser.update_attributes(:photo => thisphoto, :location_id => 1)
	  	puts "Added user"
	  else
	  	puts "Did not add user"
	  end
	end

	photos = Dir.entries("lib/tasks/photosw/")
	csv = CSV.read('lib/tasks/userwomen.csv', :headers => true, :encoding => 'iso-8859-1:utf-8')
	csv.each_with_index do |row, index|
	  dynemail = "hbkbatch01w_" + index.to_s + "@heybarkeep.co"
	  puts dynemail
	  puts photos[index]
	  next if photos[index] == '.' or photos[index] == '..'

	  filepath = "lib/tasks/photosw/" + photos[index]
	  puts filepath
	  thisphoto = File.open(filepath)

	  auser = User.create!(:name => row['name'], :email => dynemail, :password => "hbkactivity", :password_confirmation => "hbkactivity", :venueprofile => row['testprofile'], :location_id => row['location_id'], :tender => row['tender'])

	  if auser.update_attributes(:photo => thisphoto, :location_id => 1)
	  	puts "Added user"
	  else
	  	puts "Did not add user"
	  end
	end

end
