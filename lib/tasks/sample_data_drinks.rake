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
  @drink = Drink.create!(name: "Caju Amigo", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Leite de Onca", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Quentao", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Rabo-de-galo", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Royce", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Buck's Fizz", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Angel Face", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Bronx", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Gibson", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Gimlet", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Gin Fizz", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Gin Buck", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Gin and Tonic", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Gin & Tonic", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Gin Pahit", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Gin Sour", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Hanky-Panky", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "The Last Word", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Lime Rickey", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Joker", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Lorraine", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Mickey Slim", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "My Fair Lady", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Negroni", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Old Etonian", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Pall Mall", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Pegu", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Pimm's Cup", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Pink Gin", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Pink Lady", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Ramos Gin Fizz", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Royal Arrival", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Salty Dog", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Shirley Temple Black", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Vesper Martini", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "White Lady", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Wolfram", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Bacardi", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Bumbo", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Bushwacker", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Caribou Lou", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Corn N' Oil", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Culto A La Vida", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Dark and Stormy", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Dark & Stormy", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "El Presidente", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Fish House Punch", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Flaming Volcano", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Grog", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Gunfire", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Havana Cooler", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Hurricane", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Jagertee", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Macua", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Painkiller", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Planter's Punch", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Royal Bermuda Cocktail", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Rum Swizzle", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Staten Island Ferry", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Sundowner", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Ti Punch", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Tschunk", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Ginza Mary", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Tamagozake", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Bananarita", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Bloody Aztec", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Chimayo Cocktail", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "El Toro Loco", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Patron and Redbull", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Patron & Redbull", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Matador", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Paloma", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Slammer Royale", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Tequila Slammer", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Tequila Sour", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Tequila Sunrise", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Agent Orange", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Appletini", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Black Russian", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "BLT cocktail", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Bull Shot", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Blue Lagoon", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Caesar", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Caipivodka", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Caipiroska", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Cape Cod", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Chi-Chi", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Colombia", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Flirtini", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "The Goldeneye", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Godmother", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Greyhound", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Harvey Wallbanger", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Harrogate Nights", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Hi-fi", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Kamikaze", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Kensington Court Special", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Kremlin Colonel", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Link Up", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Moscow Mule", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Mudslide", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Orange Tundra", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Paralyzer", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Red Lotus", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Rose Kennedy Cocktail", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Salmiakki Koskenkorva", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Sex on the Beach", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Vesper", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Vodka Gimlet", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Vodka Martini", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Kangaroo", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Vodka McGovern", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Vodka Sundowner", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Vodka Sunrise", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Woo Woo", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Yorsh", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Amber Moon", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Blue Blazer", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Bourbon Lancer", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Churchill", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Farnell", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Four Horsemen", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Irish Coffee", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Jack and Coke", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Jungle Juice", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Jack & Coke", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Lynchburg Lemonade", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Missouri Mule", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Nixon", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Rob Roy", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Rusty Nail", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Seven and Seven", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "7 & 7", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Three Wise Men", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Whisky Mac", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Cheeky Vimto", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Agua de Valencia", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Prince of Wales", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Sangria", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Ruby Dutchess", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Kalimotxo", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Tinto de Verano", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Mulled Wine", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Glogg", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Zurracapote", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Kir", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Spritzer", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Chocolate Martini", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "B-52", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Baby Guinness", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Blow Job", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Dirty Mother", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Dirty White Mother", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Duck Fart", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Jamaican Coffee", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Oatmeal Cookie", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Buttery Nipple", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Golden Cadillac", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Grasshopper", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Oatmeal Cookie", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Pink Squirrel", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Quick Fuck", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Slippery Nipple", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Screaming Orgasm", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Golden Dream", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Golden Doublet", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Moonwalk", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Skittle Bomb", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Japanese Slipper", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Midori Sour", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Herbsaint Frappé", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Mauresque", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Perroquet", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Tomate", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Rourou", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Alabama Slammer", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Blueberry Tea", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Godfather", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Backdraft", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Carrot Cake", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Common Market", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Flaming Sambuca", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Jagerbomb", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Pucker Up", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Snowball", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Americano", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Brut Cocktail", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Schnapps", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Fuzzy Navel", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Polar Bear", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Redheaded Slut", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Pisco", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Mango Sour", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Jazmin Sour", popular: "NO", user_id:1)
  @drink = Drink.create!(name: "Aguaymanto Sour", popular: "NO", user_id:1)


end