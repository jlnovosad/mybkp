desc "This task is called by the Heroku scheduler add-on"

task :update_feed => :environment do
  puts "Updating feed..."
  
  v = Venue.find_by_name("Juke Bar")
  u = User.find_by_name("Juke Bar Staff")
  m = Micropost.create!(content: "Every night 'til 9 pm!  Not kidding! All beer, wine and well is 5 bucks. Our award winning specialty cocktails are $8! (ok.. we didn't win any awards... yet!)", venue_id: v.id, user_id:u.id)

  v = Venue.find_by_name("Yuca Bar")
  u = User.find_by_name("Yuca Bar Staff")
  m = Micropost.create!(content: "Weekdays til 8pm. Mojitos, Caipirinhas, Margaritas $7, Sangria and wine $6", venue_id: v.id, user_id:u.id)

  v = Venue.find_by_name("Phebe's")
  u = User.find_by_name("Phebe's Staff")
  m = Micropost.create!(content: "Monday to Friday 4PM to 8PM - $3- 6$ drinks", venue_id: v.id, user_id:u.id)

  v = Venue.find_by_name("The 13th Step")
  u = User.find_by_name("The 13th Step Staff")
  m = Micropost.create!(content: "Mon-Fri 1/2 price til 8pm", venue_id: v.id, user_id:u.id)

  v = Venue.find_by_name("Ace Bar")
  u = User.find_by_name("Ace Bar Staff")
  m = Micropost.create!(content: "Everyday till 8 pm. All draughts are $3 - $4. Well drinks are $4 and pint size Bloody Marys are $5.", venue_id: v.id, user_id:u.id)

  puts "done."
end