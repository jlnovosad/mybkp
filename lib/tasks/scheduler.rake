desc "This task is called by the Heroku scheduler add-on"

task :update_feed => :environment do
  puts "Updating feed..."
  
  v = Venue.find_by_name("Juke Bar Staff")
  u = User.find_by_name("Juke Bar Staff")
  m = Micropost.create!(content: "Every night 'til 9 pm!  Not kidding! All beer, wine and well is 5 bucks. Our award winning specialty cocktails are $8! (ok.. we didn't win any awards... yet!)", venue_id: v.id, user_id:u.id)

  puts "done."
end