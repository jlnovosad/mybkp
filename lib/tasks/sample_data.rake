namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_venues
    make_users
  end
end

def make_venues
  Venue.create!(fs_venue_id: "4a0e0f85f964a520bf751fe3")
  Venue.create!(fs_venue_id: "4aa9386ef964a5208b5220e3")
  Venue.create!(fs_venue_id: "4544401ff964a520623c1fe3")
  Venue.create!(fs_venue_id: "49d3d4a7f964a5201a5c1fe3")
  Venue.create!(fs_venue_id: "4cc5fbdd306e224bd829a66c")
  Venue.create!(fs_venue_id: "3fd66200f964a52018e51ee3")
  Venue.create!(fs_venue_id: "3fd66200f964a5205be81ee3")
  Venue.create!(fs_venue_id: "3fd66200f964a5208de81ee3")
  Venue.create!(fs_venue_id: "3fd66200f964a5200ae51ee3")
  Venue.create!(fs_venue_id: "4be874a488ed2d7fa3e4cb1d")
end

def make_users
  user = User.create! :name => "Al Theman", :email => "test2@mybarkeepers.com", :password => "foobar", :password_confirmation => "foobar", :tender => "YES"
  user.microposts.create!(content: "Let's have another!", :venue_id => 1)
  user.microposts.create!(content: "At Breslin havin a big pig", :venue_id => 2)
  user.follow!(User.find_by_name("J.L. Novosad"))
  user.venues << Venue.find_by_id(1)
  user.venues << Venue.find_by_id(2)

  user = User.create! :name => "Jake Trout", :email => "test3@mybarkeepers.com", :password => "foobar", :password_confirmation => "foobar", :tender => "YES"
  user.microposts.create!(content: "Beside having an great bar, did you know we serve food too?", :venue_id => 3)
  user.microposts.create!(content: "Say hi to Jimmy, the bar's namesake and city's nicest restauranteur.")
  user.follow!(User.find_by_name("J.L. Novosad"))
  user.venues << Venue.find_by_id(3)

  user = User.create! :name => "Sandeee", :email => "test4@mybarkeepers.com", :password => "foobar", :password_confirmation => "foobar", :tender => "YES"
  user.microposts.create!(content: "The view of New York, the Hudson River & New Jersey is stunning. ", :venue_id => 4)
  user.microposts.create!(content: "woooooooooooo")
  user.follow!(User.find_by_name("J.L. Novosad"))

  user = User.create! :name => "Kim O'Connor", :email => "test5@mybarkeepers.com", :password => "foobar", :password_confirmation => "foobar", :tender => "YES"
  user.microposts.create!(content: "slick your hair back, listen to some huey lewis", :venue_id => 4)
  user.microposts.create!(content: "Check out the rooftop bar")
  user.follow!(User.find_by_name("J.L. Novosad"))
  user.venues << Venue.find_by_id(4)

  user = User.create! :name => "Mr. Popular", :email => "mybarkeepers@lifestylesupply.co", :password => "foobar", :password_confirmation => "foobar"
  user.follow!(User.find_by_name("Al Theman"))
end