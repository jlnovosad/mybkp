namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
   
  u = User.create :password => "mbkhappyuser", :password_confirmation => "mbkhappyuser", :tender => "NO", :invited_by_id => "1", :invited_by_type => "User", :name => "Yuca Bar Staff", :email => "yucabar@mybarkeepers.com", :venueprofile => "YES"

  u = User.create :password => "mbkhappyuser", :password_confirmation => "mbkhappyuser", :tender => "NO", :invited_by_id => "1", :invited_by_type => "User", :name => "Phebe's Staff", :email => "phebes@mybarkeepers.com", :venueprofile => "YES"

  u = User.create :password => "mbkhappyuser", :password_confirmation => "mbkhappyuser", :tender => "NO", :invited_by_id => "1", :invited_by_type => "User", :name => "The 13th Step Staff", :email => "the13thstep@mybarkeepers.com", :venueprofile => "YES"

  u = User.create :password => "mbkhappyuser", :password_confirmation => "mbkhappyuser", :tender => "NO", :invited_by_id => "1", :invited_by_type => "User", :name => "Ace Bar Staff", :email => "acebar@mybarkeepers.com", :venueprofile => "YES"

  end
end
