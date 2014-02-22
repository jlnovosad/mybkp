namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_categories
    make_drinks
  end
end

def make_categories
  Category.create!(name: "Summertime", popular: "YES")
  Category.create!(name: "Mixology", popular: "YES")
  Category.create!(name: "Martini", popular: "YES")
  Category.create!(name: "Sweet", popular: "YES")
  Category.create!(name: "Sour", popular: "YES")
  Category.create!(name: "Bitter", popular: "YES")

  Category.create!(name: "Beer", popular: "YES")
	Category.create!(name: "Brandy or Cognac", popular: "YES")
	Category.create!(name: "Champagne", popular: "YES")
	Category.create!(name: "Gin", popular: "YES")
	Category.create!(name: "Rum", popular: "YES")
	Category.create!(name: "Sake", popular: "YES")
	Category.create!(name: "Tequila", popular: "YES")
	Category.create!(name: "Vodka", popular: "YES")
	Category.create!(name: "Whiskey", popular: "YES")
	Category.create!(name: "Wine", popular: "YES")
	Category.create!(name: "Coffee", popular: "YES")
end

def make_drinks
	Drink.create!(name: "Mai Tai", popular: "YES", user_id:1)
	Drink.create!(name: "White Russian", popular: "YES", user_id:1)
	Drink.create!(name: "Caipirinha", popular: "YES", user_id:1)
	Drink.create!(name: "Screwdriver", popular: "YES", user_id:1)
	Drink.create!(name: "Whiskey Sour", popular: "YES", user_id:1)
	Drink.create!(name: "Old Fashioned", popular: "YES", user_id:1)
	Drink.create!(name: "Singapore Sling", popular: "YES", user_id:1)
	Drink.create!(name: "Mojito", popular: "YES", user_id:1)
	Drink.create!(name: "Daquiri", popular: "YES")
	Drink.create!(name: "Mint Julep", popular: "YES", user_id:1)
	Drink.create!(name: "Tom Collins", popular: "YES", user_id:1)
	Drink.create!(name: "Cosmopolitan", popular: "YES", user_id:1)
	Drink.create!(name: "Pina Colada", popular: "YES", user_id:1)
	Drink.create!(name: "Sea Breeze", popular: "YES", user_id:1)
	Drink.create!(name: "Cuba Libre", popular: "YES", user_id:1)
	Drink.create!(name: "Bellini", popular: "YES", user_id:1)
	Drink.create!(name: "Mimosa", popular: "YES", user_id:1)
	Drink.create!(name: "Apple Martini", popular: "NO", user_id:1)
	Drink.create!(name: "Kir Royale", popular: "NO", user_id:1)
	Drink.create!(name: "Long Island Iced Tea", popular: "YES", user_id:1)

	Drink.create!(name: "Alexander", popular: "NO", user_id:1)
	Drink.create!(name: "Blue Hawaii", popular: "NO", user_id:1)
	Drink.create!(name: "Margarita", popular: "YES", user_id:1)
	Drink.create!(name: "Bay Breeze", popular: "NO", user_id:1)
	Drink.create!(name: "Bloody Mary", popular: "YES", user_id:1)
	Drink.create!(name: "Sazerac", popular: "YES", user_id:1)
	Drink.create!(name: "Manhattan", popular: "YES", user_id:1)
	Drink.create!(name: "Martini", popular: "YES", user_id:1)
	Drink.create!(name: "Michelada", popular: "YES", user_id:1)
	Drink.create!(name: "20th Century", popular: "NO", user_id:1)
	Drink.create!(name: "Aviation", popular: "NO", user_id:1)
	Drink.create!(name: "Bijou", popular: "NO", user_id:1)
	Drink.create!(name: "Bloodhound", popular: "NO", user_id:1)
	Drink.create!(name: "French 75", popular: "NO", user_id:1)
end