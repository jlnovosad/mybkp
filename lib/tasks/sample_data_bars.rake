namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
  	u = User.create :password => "mbkhappy", :password_confirmation => "mbkhappy", :tender => "NO", :invited_by_id => "1", :invited_by_type => "User", :name => "Juke Bar Staff", :email => "jukebar@mybarkeepers.com", :venueprofile => "YES"
  end
end
