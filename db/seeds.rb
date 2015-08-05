CATEGORIES = [
  "Cafe",
  "Restaurant",
  "Diner",
  "Pub",
  "Cocktail Bar",
  "Dive Bar",
  "Hole in the Wall",
  "Fast Food",
  "Food Court",
  "Coffee House",
  "Grill",
  "Desserts",
  "Bakery",
  "Food Truck",
  "Concert Hall",
  "Nightclub",
  "Theater",
  "Beer Garden"
]

CATEGORIES.each do |category|
  Category.find_or_create_by!(name: category)
end

10.times { FactoryGirl.create(:venue, approved: true) }
