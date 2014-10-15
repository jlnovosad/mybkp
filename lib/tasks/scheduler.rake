desc "This task is called by the Heroku scheduler add-on"

task :update_feed => :environment do
  puts "Updating feed..."
  
  @v = Venue.new
  @u = User.new
  @m = Micropost.new
  
  if Time.now.monday?

  @v = Venue.find_by_name("Juke Bar")
  @u = User.find_by_name("Juke Bar")
  @m = Micropost.create!(content: "Every night 'til 9 pm!  Not kidding! All beer, wine and well is 5 bucks. Our award winning specialty cocktails are $8! (ok.. we didn't win any awards... yet!)", user_id:@u.id)
  @c = Checkin.create!(micropost_id: @m.id, user_id:@u.id, venue_id: @v.id)

  @v = Venue.find_by_name("Cariño Restaurant and Cantina")
  @u = User.find_by_name("Cariño Restaurant and Cantina")
  @m = Micropost.create!(content: "Monday, Thursday and Friday 4pm-7pm, $4 glass of red sangria; $5 house & frozen margaritas; $5 tequila and Tecate; $5 Dos XX Amber and Pacifico beers on draft", user_id:@u.id)
  @c = Checkin.create!(micropost_id: @m.id, user_id:@u.id, venue_id: @v.id)

  @v = Venue.find_by_name("La Cava Wine Bar")
  @u = User.find_by_name("La Cava Wine Bar")
  @m = Micropost.create!(content: "$7 glass of wine, $5 beers, Mon-Fri 12pm-7pm", user_id:@u.id)
  @c = Checkin.create!(micropost_id: @m.id, user_id:@u.id, venue_id: @v.id)

  @v = Venue.find_by_name("Rattle N Hum")
  @u = User.find_by_name("Rattle N Hum")
  @m = Micropost.create!(content: "$5 well drinks, select beers, wines, Mon-Fri 11am-7pm", user_id:@u.id)
  @c = Checkin.create!(micropost_id: @m.id, user_id:@u.id, venue_id: @v.id)

  end


  if Time.now.tuesday?
  
  @v = Venue.find_by_name("Thirsty Scholar")
  @u = User.find_by_name("Thirsty Scholar")
  @m = Micropost.create!(content: "$4 Bud Light, well drinks, PBRs, $5 glasses of wine, other draft beers, $7 martinis, Manhattans", user_id:@u.id)
  @c = Checkin.create!(micropost_id: @m.id, user_id:@u.id, venue_id: @v.id)

  @v = Venue.find_by_name("Formerly Crow's")
  @u = User.find_by_name("Formerly Crow's")
  @m = Micropost.create!(content: "2 for 1 well drinks, $1 off select draft beers", user_id:@u.id)
  @c = Checkin.create!(micropost_id: @m.id, user_id:@u.id, venue_id: @v.id)

  @v = Venue.find_by_name("Sazón")
  @u = User.find_by_name("Sazón")
  @m = Micropost.create!(content: "$6 sangria, mojitos, imported beers, $2 empanadas, Mon-Fri 12pm-7pm", user_id:@u.id)
  @c = Checkin.create!(micropost_id: @m.id, user_id:@u.id, venue_id: @v.id)

  @v = Venue.find_by_name("Stitch Bar & Lounge")
  @u = User.find_by_name("Stitch Bar & Lounge")
  @m = Micropost.create!(content: "$6 draft beers, $8 red or white wines, cosmopolitan, appletinis, $7 red or white sangria, Mon-Fri 11am-7pm", user_id:@u.id)
  @c = Checkin.create!(micropost_id: @m.id, user_id:@u.id, venue_id: @v.id)

  end


  if Time.now.wednesday?
  
  @v = Venue.find_by_name("Pianos")
  @u = User.find_by_name("Pianos")
  @m = Micropost.create!(content: "$4 beers, wines, well drinks; $5 margaritas, every day 2pm-8pm", user_id:@u.id)
  @c = Checkin.create!(micropost_id: @m.id, user_id:@u.id, venue_id: @v.id)

  @v = Venue.find_by_name("Hill Country Barbecue Market")
  @u = User.find_by_name("Hill Country Barbecue Market")
  @m = Micropost.create!(content: "$3 PBRs, $5 premium beers, and $20 margarita pitchers, every day 4pm-7pm", user_id:@u.id)
  @c = Checkin.create!(micropost_id: @m.id, user_id:@u.id, venue_id: @v.id)

  @v = Venue.find_by_name("Dalton's Bar And Grill")
  @u = User.find_by_name("Dalton's Bar And Grill")
  @m = Micropost.create!(content: "$4 draft beers, bottled beers, $5 shots, well drinks, wines, select martinis, Mon-Fri 12pm-8pm", user_id:@u.id)
  @c = Checkin.create!(micropost_id: @m.id, user_id:@u.id, venue_id: @v.id)

  @v = Venue.find_by_name("Astoria Brewhouse")
  @u = User.find_by_name("Astoria Brewhouse")
  @m = Micropost.create!(content: "$4 select pints of domestic beer, bottled beers; $5 wines, well drinks, call drinks, Mon-Fri 11am-7pm", user_id:@u.id)
  @c = Checkin.create!(micropost_id: @m.id, user_id:@u.id, venue_id: @v.id)

  end


  if Time.now.thursday?
  
  @v = Venue.find_by_name("Casa Nonna")
  @u = User.find_by_name("Casa Nonna")
  @m = Micropost.create!(content: "Discounted cocktails, beer and wine, complimentary hot and cold appetizers at the bar with drink purchase!", user_id:@u.id)
  @c = Checkin.create!(micropost_id: @m.id, user_id:@u.id, venue_id: @v.id)

  @v = Venue.find_by_name("Crocodile Lounge")
  @u = User.find_by_name("Crocodile Lounge")
  @m = Micropost.create!(content: "FREE PIZZA EVERYDAY! Specials from 12pm-7pm M-F $3 Yuenglings, $4 Bud Light Draft, $1 off all other drafts, $4 well drinks, $6 Bottle Miller High Life with shot of whiskey", user_id:@u.id)
  @c = Checkin.create!(micropost_id: @m.id, user_id:@u.id, venue_id: @v.id)

  @v = Venue.find_by_name("Joshua Tree")
  @u = User.find_by_name("Joshua Tree")
  @m = Micropost.create!(content: "$4 Yuengling, Bud, Bud LIght, $5 mixed drinks, wine, every day 12pm-8pm", user_id:@u.id)
  @c = Checkin.create!(micropost_id: @m.id, user_id:@u.id, venue_id: @v.id)

  @v = Venue.find_by_name("Zablozki's")
  @u = User.find_by_name("Zablozki's")
  @m = Micropost.create!(content: "$3 well drinks, $1 off draft beers, Mon-Fri 2pm-8pm", user_id:@u.id)
  @c = Checkin.create!(micropost_id: @m.id, user_id:@u.id, venue_id: @v.id)

  end


  if Time.now.friday?
  
  @v = Venue.find_by_name("The Stumble Inn")
  @u = User.find_by_name("The Stumble Inn")
  @m = Micropost.create!(content: "1/2 Price Bar, 11:30am-7pm Mon-Sat", user_id:@u.id)
  @c = Checkin.create!(micropost_id: @m.id, user_id:@u.id, venue_id: @v.id)

  @v = Venue.find_by_name("West 3rd Common")
  @u = User.find_by_name("West 3rd Common")
  @m = Micropost.create!(content: "$4 draft beers, $5 wines, well drinks, cosmopolitans, appletinis, Mon-Fri 12pm-8pm", user_id:@u.id)
  @c = Checkin.create!(micropost_id: @m.id, user_id:@u.id, venue_id: @v.id)

  @v = Venue.find_by_name("The House of Brews")
  @u = User.find_by_name("The House of Brews")
  @m = Micropost.create!(content: "$5 margaritas, cosmopolitans, appletinis, select draft beers, select bottled beers, Mon-Fri 11am-7pm", user_id:@u.id)
  @c = Checkin.create!(micropost_id: @m.id, user_id:@u.id, venue_id: @v.id)

  @v = Venue.find_by_name("Barbossa")
  @u = User.find_by_name("Barbossa")
  @m = Micropost.create!(content: "$5 draft beers, $6 house red wines, house write wines, Mon-Fri 11am-7pm", user_id:@u.id)
  @c = Checkin.create!(micropost_id: @m.id, user_id:@u.id, venue_id: @v.id)

  end


  if Time.now.saturday?
    
  @v = Venue.find_by_name("Ten Degrees")
  @u = User.find_by_name("Ten Degrees")
  @m = Micropost.create!(content: "2 for 1 happy hour every day from 12-8pm", user_id:@u.id)
  @c = Checkin.create!(micropost_id: @m.id, user_id:@u.id, venue_id: @v.id)

  @v = Venue.find_by_name("City Crab & Seafood Company")
  @u = User.find_by_name("City Crab & Seafood Company")
  @m = Micropost.create!(content: "Wine, beer & specialty cocktails are HALF OFF during Happy Hour! 4-7pm Monday-Friday", user_id:@u.id)
  @c = Checkin.create!(micropost_id: @m.id, user_id:@u.id, venue_id: @v.id)

  @v = Venue.find_by_name("The Gin Mill")
  @u = User.find_by_name("The Gin Mill")
  @m = Micropost.create!(content: "1/2 Price Bar, 11:30am-8pm Mon-Sat", user_id:@u.id)
  @c = Checkin.create!(micropost_id: @m.id, user_id:@u.id, venue_id: @v.id)

  @v = Venue.find_by_name("Verlaine Bar & Lounge")
  @u = User.find_by_name("Verlaine Bar & Lounge")
  @m = Micropost.create!(content: "5 to 10pm, 7 days a week., $6 Hanoi Lychee Martinis, Sangrias, Vietnamese Bloody Marys, $6 House red & white wines, basic cocktails, $3 bottles of Yuengling", user_id:@u.id)
  @c = Checkin.create!(micropost_id: @m.id, user_id:@u.id, venue_id: @v.id)

  end


  if Time.now.sunday?
  
  @v = Venue.find_by_name("Broadway Dive Bar")
  @u = User.find_by_name("Broadway Dive Bar")
  @m = Micropost.create!(content: "$3 Bud, Bud Light, $4 Corona, Heineken, $5 well drinks, wines, $2 off domestic draft beers, every day 12pm-7pm", user_id:@u.id)
  @c = Checkin.create!(micropost_id: @m.id, user_id:@u.id, venue_id: @v.id)

  @v = Venue.find_by_name("Iona")
  @u = User.find_by_name("Iona")
  @m = Micropost.create!(content: "$4 Stella, $3 Yuengling drafts, well drinks, $5 Smithwicks's, every day 1pm-7pm", user_id:@u.id)
  @c = Checkin.create!(micropost_id: @m.id, user_id:@u.id, venue_id: @v.id)

  @v = Venue.find_by_name("123 Burger Shot Beer")
  @u = User.find_by_name("123 Burger Shot Beer")
  @m = Micropost.create!(content: "$1 burgers, $2 shots, $3 beers every day 11am-8pm", user_id:@u.id)
  @c = Checkin.create!(micropost_id: @m.id, user_id:@u.id, venue_id: @v.id)

  @v = Venue.find_by_name("Keybar")
  @u = User.find_by_name("Keybar")
  @m = Micropost.create!(content: "Our legendary 2 for 1 Happy Hour on EVERYTHING is BACK for EVERY DAY/7 days a week!", user_id:@u.id)
  @c = Checkin.create!(micropost_id: @m.id, user_id:@u.id, venue_id: @v.id)

  end
end
