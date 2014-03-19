namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    #make_categories
    make_morecategories
    end
end

def make_categories
  @category = Category.create!(name: "Alexander", popular: "NO")
  @category = Category.create!(name: "Collins", popular: "YES")
  @category = Category.create!(name: "Daiquiri", popular: "YES")
  @category = Category.create!(name: "Fizz", popular: "YES")
  @category = Category.create!(name: "Highball", popular: "YES")
  @category = Category.create!(name: "Iced Tea", popular: "YES")
  @category = Category.create!(name: "Cooler", popular: "NO")
  @category = Category.create!(name: "Julep", popular: "NO")
  @category = Category.create!(name: "Manhattan", popular: "NO")
  @category = Category.create!(name: "Margarita", popular: "YES")
  @category = Category.create!(name: "Rickey", popular: "NO")
  @category = Category.create!(name: "Punch", popular: "YES")
  @category = Category.create!(name: "Armagnac", popular: "NO")
  @category = Category.create!(name: "Cognac", popular: "YES")
  @category = Category.create!(name: "Schnapps", popular: "NO")
  @category = Category.create!(name: "Cream Liqueur", popular: "YES")
  @category = Category.create!(name: "Orange", popular: "NO")
  @category = Category.create!(name: "Midori", popular: "NO")
  @category = Category.create!(name: "Galliano", popular: "NO")
  @category = Category.create!(name: "Herbsaint", popular: "NO")
  @category = Category.create!(name: "Pastis", popular: "NO")
  @category = Category.create!(name: "Almond", popular: "NO")
  @category = Category.create!(name: "Bitters", popular: "YES")
  @category = Category.create!(name: "Shots", popular: "YES")
  @category = Category.create!(name: "Lillet", popular: "NO")
  @category = Category.create!(name: "Amaretto", popular: "NO")
  @category = Category.create!(name: "Amaro", popular: "NO")
  
	
  @category = Category.create!(name: "Absinthe", popular: "NO")
  @category = Category.create!(name: "Akvavit", popular: "NO")
  @category = Category.create!(name: "Applejack", popular: "NO")
  @category = Category.create!(name: "Cachaca", popular: "YES")
  @category = Category.create!(name: "Sloe Gin", popular: "NO")
  @category = Category.create!(name: "Mezcal", popular: "YES")
  @category = Category.create!(name: "Ouzo", popular: "NO")
  @category = Category.create!(name: "Pisco", popular: "NO")
  @category = Category.create!(name: "Shochu", popular: "NO")
  @category = Category.create!(name: "Soju", popular: "YES")
  @category = Category.create!(name: "Whisky", popular: "YES")
  @category = Category.create!(name: "Whiskey (Bourbon)", popular: "YES")
  @category = Category.create!(name: "Whiskey (Rye)", popular: "YES")
  @category = Category.create!(name: "Whiskey (Irish)", popular: "YES")
  @category = Category.create!(name: "Whisky (Japanese)", popular: "YES")
  @category = Category.create!(name: "Whisky (Scotch)", popular: "YES")
  @category = Category.create!(name: "Whiskey (Tennessee)", popular: "YES")
  @category = Category.create!(name: "Whisky (Canadian)", popular: "YES")
end

def make_morecategories
  @category = Category.create!(name: "Milk", popular: "NO")
  @category = Category.create!(name: "Vermouth", popular: "NO")
  @category = Category.create!(name: "Orange Juice", popular: "NO")
  @category = Category.create!(name: "Lime Juice", popular: "NO")
  @category = Category.create!(name: "Lemon Juice", popular: "NO")
  @category = Category.create!(name: "Pimm's", popular: "NO")
  @category = Category.create!(name: "Tonic", popular: "NO")
  @category = Category.create!(name: "Sour", popular: "YES")
  @category = Category.create!(name: "Fernet", popular: "NO")
  @category = Category.create!(name: "Highball", popular: "YES")
end
