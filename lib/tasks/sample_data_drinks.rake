namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    #make_drinks
  end
end

def make_drinks
  @drink = Drink.create!(name: "Corpse Reviver #2", popular: "NO", user_id:1)
  	@category = Category.find_by_name("Absinthe")
    @drink.categories << @category 
	@category = Category.find_by_name("Gin")
    @drink.categories << @category 
	
  @drink = Drink.create!(name: "Death in the Afternoon", popular: "NO", user_id:1)
  	@category = Category.find_by_name("Absinthe")
    @drink.categories << @category 
	@category = Category.find_by_name("Champagne")
    @drink.categories << @category 
	
  @drink = Drink.create!(name: "Hemingway Champagne", popular: "NO", user_id:1)
  	@category = Category.find_by_name("Absinthe")
    @drink.categories << @category 
	@category = Category.find_by_name("Champagne")
    @drink.categories << @category 
	
  @drink = Drink.create!(name: "Earthquake", popular: "NO", user_id:1)
 	@category = Category.find_by_name("Absinthe")
    @drink.categories << @category 
	@category = Category.find_by_name("Brandy/Cognac")
    @drink.categories << @category 
	
  @drink = Drink.create!(name: "Vesper", popular: "NO", user_id:1)
   	@category = Category.find_by_name("Gin")
    @drink.categories << @category 
	@category = Category.find_by_name("Lillet")
    @drink.categories << @category 
	
  @drink = Drink.create!(name: "The Monkey Gland", popular: "NO", user_id:1)
   	@category = Category.find_by_name("Gin")
    @drink.categories << @category 
	@category = Category.find_by_name("Absinthe")
    @drink.categories << @category 
	
  @drink = Drink.create!(name: "Black and Tan", popular: "NO", user_id:1)
    @category = Category.find_by_name("Beer")
    @drink.categories << @category 
	
  @drink = Drink.create!(name: "Black & Tan", popular: "NO", user_id:1)
    @category = Category.find_by_name("Beer")
    @drink.categories << @category 
	
  @drink = Drink.create!(name: "Black Velvet", popular: "NO", user_id:1)
    @category = Category.find_by_name("Beer")
    @drink.categories << @category 
	
  @drink = Drink.create!(name: "Flaming Dr Pepper", popular: "NO", user_id:1)
    @category = Category.find_by_name("Beer")
    @drink.categories << @category 
	@category = Category.find_by_name("Shots")
    @drink.categories << @category 
	@category = Category.find_by_name("Amaretto")
    @drink.categories << @category 
	
  @drink = Drink.create!(name: "Irish Car Bomb", popular: "NO", user_id:1)
    @category = Category.find_by_name("Beer")
    @drink.categories << @category 
	@category = Category.find_by_name("Shots")
    @drink.categories << @category 
	
  @drink = Drink.create!(name: "Sake Bomb", popular: "NO", user_id:1)
    @category = Category.find_by_name("Beer")
    @drink.categories << @category 
	@category = Category.find_by_name("Shots")
    @drink.categories << @category 
	@category = Category.find_by_name("Sake")
    @drink.categories << @category 
	
  @drink = Drink.create!(name: "Shandy", popular: "NO", user_id:1)
    @category = Category.find_by_name("Beer")
    @drink.categories << @category 
	
  @drink = Drink.create!(name: "U-Boot", popular: "NO", user_id:1)
    @category = Category.find_by_name("Beer")
    @drink.categories << @category
	@category = Category.find_by_name("Shots")
    @drink.categories << @category 
	
  @drink = Drink.create!(name: "B & B", popular: "NO", user_id:1)
    @category = Category.find_by_name("Brandy/Cognac")
    @drink.categories << @category
	
  @drink = Drink.create!(name: "Brandy Alexander", popular: "NO", user_id:1)
    @category = Category.find_by_name("Brandy/Cognac")
    @drink.categories << @category
	
  @drink = Drink.create!(name: "Brandy Manhattan", popular: "NO", user_id:1)
    @category = Category.find_by_name("Brandy/Cognac")
    @drink.categories << @category
	
  @drink = Drink.create!(name: "Brandy Sour", popular: "NO", user_id:1)
    @category = Category.find_by_name("Brandy/Cognac")
    @drink.categories << @category
    @category = Category.find_by_name("Sour")
    @drink.categories << @category
	
  @drink = Drink.create!(name: "Chicago Cocktail", popular: "NO", user_id:1)
    @category = Category.find_by_name("Brandy/Cognac")
    @drink.categories << @category
	
  @drink = Drink.create!(name: "Curacao Punch", popular: "NO", user_id:1)
    @category = Category.find_by_name("Brandy/Cognac")
    @drink.categories << @category
	
  @drink = Drink.create!(name: "Four Score", popular: "NO", user_id:1)
    @category = Category.find_by_name("Brandy/Cognac")
    @drink.categories << @category
	
  @drink = Drink.create!(name: "French Connection", popular: "NO", user_id:1)
    @category = Category.find_by_name("Brandy/Cognac")
    @drink.categories << @category
	
  @drink = Drink.create!(name: "Horse's Neck", popular: "NO", user_id:1)
    @category = Category.find_by_name("Brandy/Cognac")
    @drink.categories << @category
	
  @drink = Drink.create!(name: "Incredible Hulk", popular: "NO", user_id:1)
    @category = Category.find_by_name("Brandy/Cognac")
    @drink.categories << @category
	
  @drink = Drink.create!(name: "Jack Rose", popular: "NO", user_id:1)
    @category = Category.find_by_name("Brandy/Cognac")
    @drink.categories << @category
	
  @drink = Drink.create!(name: "Nikolaschka", popular: "NO", user_id:1)
    @category = Category.find_by_name("Brandy/Cognac")
    @drink.categories << @category
	
  @drink = Drink.create!(name: "Orgasm", popular: "NO", user_id:1)
    @category = Category.find_by_name("Brandy/Cognac")
    @drink.categories << @category
	
  @drink = Drink.create!(name: "Panama", popular: "NO", user_id:1)
    @category = Category.find_by_name("Brandy/Cognac")
    @drink.categories << @category
	
  @drink = Drink.create!(name: "Paradise", popular: "NO", user_id:1)
    @category = Category.find_by_name("Brandy/Cognac")
    @drink.categories << @category
	 
  @drink = Drink.create!(name: "Pisco Sour", popular: "NO", user_id:1)
    @category = Category.find_by_name("Brandy/Cognac")
    @drink.categories << @category
    @category = Category.find_by_name("Sour")
    @drink.categories << @category
	
  @drink = Drink.create!(name: "Piscola", popular: "NO", user_id:1)
    @category = Category.find_by_name("Brandy/Cognac")
    @drink.categories << @category
	
  @drink = Drink.create!(name: "Porto Flip", popular: "NO", user_id:1)
    @category = Category.find_by_name("Brandy/Cognac")
    @drink.categories << @category
	
  @drink = Drink.create!(name: "Savoy Affair", popular: "NO", user_id:1)
    @category = Category.find_by_name("Brandy/Cognac")
    @drink.categories << @category
	
  @drink = Drink.create!(name: "Savoy Corpse Reviver", popular: "NO", user_id:1)
    @category = Category.find_by_name("Brandy/Cognac")
    @drink.categories << @category
	
  @drink = Drink.create!(name: "Sidecar", popular: "NO", user_id:1) 
    @category = Category.find_by_name("Brandy/Cognac")
    @drink.categories << @category
	
  @drink = Drink.create!(name: "Stinger", popular: "NO", user_id:1)
    @category = Category.find_by_name("Brandy/Cognac")
    @drink.categories << @category
	
  @drink = Drink.create!(name: "The Blenheim", popular: "NO", user_id:1)
    @category = Category.find_by_name("Brandy/Cognac")
    @drink.categories << @category
	
  @drink = Drink.create!(name: "Zombie", popular: "NO", user_id:1)
    @category = Category.find_by_name("Brandy/Cognac")
    @drink.categories << @category
	
  @drink = Drink.create!(name: "Batida", popular: "NO", user_id:1)
  @category = Category.find_by_name("Cachaca")
    @drink.categories << @category

  @drink = Drink.create!(name: "Caju Amigo", popular: "NO", user_id:1)
  @category = Category.find_by_name("Cachaca")
    @drink.categories << @category

  @drink = Drink.create!(name: "Leite de Onca", popular: "NO", user_id:1)
  @category = Category.find_by_name("Cachaca")
    @drink.categories << @category
    @category = Category.find_by_name("Milk")
    @drink.categories << @category

  @drink = Drink.create!(name: "Quentao", popular: "NO", user_id:1)
  @category = Category.find_by_name("Cachaca")
    @drink.categories << @category

  @drink = Drink.create!(name: "Rabo-de-galo", popular: "NO", user_id:1)
  @category = Category.find_by_name("Cachaca")
    @drink.categories << @category

  @drink = Drink.create!(name: "Royce", popular: "NO", user_id:1)
  @category = Category.find_by_name("Cachaca")
    @drink.categories << @category

  @drink = Drink.create!(name: "Buck's Fizz", popular: "NO", user_id:1)
  @category = Category.find_by_name("Champagne")
    @drink.categories << @category

  @drink = Drink.create!(name: "Angel Face", popular: "NO", user_id:1)
  @category = Category.find_by_name("Gin")
    @drink.categories << @category

  @drink = Drink.create!(name: "Bronx", popular: "NO", user_id:1)
  @category = Category.find_by_name("Gin")
    @drink.categories << @category
    @category = Category.find_by_name("Martini")
    @drink.categories << @category
    @category = Category.find_by_name("Orange Juice")
    @drink.categories << @category

  @drink = Drink.create!(name: "Gibson", popular: "NO", user_id:1)
  @category = Category.find_by_name("Gin")
    @drink.categories << @category

  @drink = Drink.create!(name: "Gimlet", popular: "NO", user_id:1)
  @category = Category.find_by_name("Gin")
    @drink.categories << @category

  @drink = Drink.create!(name: "Gin Fizz", popular: "NO", user_id:1)
  @category = Category.find_by_name("Gin")
    @drink.categories << @category
    @category = Category.find_by_name("Lemon Juice")
    @drink.categories << @category

  @drink = Drink.create!(name: "Gin Buck", popular: "NO", user_id:1)
  @category = Category.find_by_name("Gin")
    @drink.categories << @category

  @drink = Drink.create!(name: "Gin and Tonic", popular: "NO", user_id:1)
  @category = Category.find_by_name("Gin")
    @drink.categories << @category

  @drink = Drink.create!(name: "Gin & Tonic", popular: "NO", user_id:1)
  @category = Category.find_by_name("Gin")
    @drink.categories << @category
    @category = Category.find_by_name("Tonic")
    @drink.categories << @category
    @category = Category.find_by_name("Highball")
    @drink.categories << @category

  @drink = Drink.create!(name: "Gin Pahit", popular: "NO", user_id:1)
  @category = Category.find_by_name("Gin")
    @drink.categories << @category
    @category = Category.find_by_name("Bitters")
    @drink.categories << @category

  @drink = Drink.create!(name: "Gin Sour", popular: "NO", user_id:1)
  @category = Category.find_by_name("Gin")
    @drink.categories << @category
    @category = Category.find_by_name("Sour")
    @drink.categories << @category

  @drink = Drink.create!(name: "Hanky-Panky", popular: "NO", user_id:1)
  @category = Category.find_by_name("Gin")
    @drink.categories << @category
    @category = Category.find_by_name("Fernet")
    @drink.categories << @category

  @drink = Drink.create!(name: "The Last Word", popular: "NO", user_id:1)
  @category = Category.find_by_name("Gin")
    @drink.categories << @category

  @drink = Drink.create!(name: "Lime Rickey", popular: "NO", user_id:1)
  @category = Category.find_by_name("Gin")
    @drink.categories << @category
    @category = Category.find_by_name("Lime Juice")
    @drink.categories << @category

  @drink = Drink.create!(name: "Negroni", popular: "NO", user_id:1)
  @category = Category.find_by_name("Gin")
    @drink.categories << @category
    @category = Category.find_by_name("Bitters")
    @drink.categories << @category

  @drink = Drink.create!(name: "Pimm's Cup", popular: "NO", user_id:1)
  @category = Category.find_by_name("Gin")
    @drink.categories << @category
    @category = Category.find_by_name("Pimm's")
    @drink.categories << @category
    @category = Category.find_by_name("Highball")
    @drink.categories << @category

  @drink = Drink.create!(name: "Ramos Gin Fizz", popular: "NO", user_id:1)
  @category = Category.find_by_name("Gin")
    @drink.categories << @category
    @category = Category.find_by_name("Lemon Juice")
    @drink.categories << @category

  @drink = Drink.create!(name: "Salty Dog", popular: "NO", user_id:1)
  @category = Category.find_by_name("Gin")
    @drink.categories << @category
    @category = Category.find_by_name("Highball")
    @drink.categories << @category

  @drink = Drink.create!(name: "Shirley Temple Black", popular: "NO", user_id:1)
  @category = Category.find_by_name("Gin")
    @drink.categories << @category

  @drink = Drink.create!(name: "Dark and Stormy", popular: "NO", user_id:1)
  @category = Category.find_by_name("Rum")
    @drink.categories << @category

  @drink = Drink.create!(name: "Dark & Stormy", popular: "NO", user_id:1)
  @category = Category.find_by_name("Rum")
    @drink.categories << @category

  @drink = Drink.create!(name: "Paloma", popular: "NO", user_id:1)
  @category = Category.find_by_name("Rum")
    @drink.categories << @category

  @drink = Drink.create!(name: "Slammer Royale", popular: "NO", user_id:1)
  @category = Category.find_by_name("Tequila")
    @drink.categories << @category

  @drink = Drink.create!(name: "Tequila Slammer", popular: "NO", user_id:1)
  @category = Category.find_by_name("Tequila")
    @drink.categories << @category

  @drink = Drink.create!(name: "Tequila Sour", popular: "NO", user_id:1)
  @category = Category.find_by_name("Sour")
    @drink.categories << @category
    @category = Category.find_by_name("Tequila")
    @drink.categories << @category

  @drink = Drink.create!(name: "Tequila Sunrise", popular: "NO", user_id:1)
  @category = Category.find_by_name("Tequila")
    @drink.categories << @category
    @category = Category.find_by_name("Orange Juice")
    @drink.categories << @category

  @drink = Drink.create!(name: "Appletini", popular: "NO", user_id:1)
  @category = Category.find_by_name("Martini")
    @drink.categories << @category
    @category = Category.find_by_name("Vodka")
    @drink.categories << @category

  @drink = Drink.create!(name: "Black Russian", popular: "NO", user_id:1)
  @category = Category.find_by_name("Vodka")
    @drink.categories << @category
    @category = Category.find_by_name("Coffee")
    @drink.categories << @category
    
  @drink = Drink.create!(name: "Moscow Mule", popular: "NO", user_id:1)
  @category = Category.find_by_name("Highball")
    @drink.categories << @category

  @drink = Drink.create!(name: "Irish Coffee", popular: "NO", user_id:1)
  @category = Category.find_by_name("Coffee")
    @drink.categories << @category
    @category = Category.find_by_name("Whiskey (Irish)")
    @drink.categories << @category

  @drink = Drink.create!(name: "Jack and Coke", popular: "NO", user_id:1)
  @category = Category.find_by_name("Highball")
    @drink.categories << @category
    @category = Category.find_by_name("Whiskey (Tennessee)")
    @drink.categories << @category

  @drink = Drink.create!(name: "Jack & Coke", popular: "NO", user_id:1)
  @category = Category.find_by_name("Highball")
    @drink.categories << @category
    @category = Category.find_by_name("Whiskey (Tennessee)")
    @drink.categories << @category

  @drink = Drink.create!(name: "Seven and Seven", popular: "NO", user_id:1)
  @category = Category.find_by_name("Highball")
    @drink.categories << @category
    @category = Category.find_by_name("Whisky (Canadian)")
    @drink.categories << @category

  @drink = Drink.create!(name: "7 & 7", popular: "NO", user_id:1)
  @category = Category.find_by_name("Highball")
    @drink.categories << @category
    @category = Category.find_by_name("Whisky (Canadian)")
    @drink.categories << @category

  @drink = Drink.create!(name: "Midori Sour", popular: "NO", user_id:1)
  @category = Category.find_by_name("Sour")
    @drink.categories << @category

  @drink = Drink.create!(name: "Mango Sour", popular: "NO", user_id:1)
  @category = Category.find_by_name("Sour")
    @drink.categories << @category

  @drink = Drink.create!(name: "Jazmin Sour", popular: "NO", user_id:1)
  @category = Category.find_by_name("Sour")
    @drink.categories << @category

  @drink = Drink.create!(name: "Aguaymanto Sour", popular: "NO", user_id:1)
  @category = Category.find_by_name("Sour")
    @drink.categories << @category


end