CATEGORIES = [
  'Cafe',
  'Restaurant',
  'Diner',
  'Pub',
  'Cocktail Bar',
  'Dive Bar',
  'Hole in the Wall',
  'Fast Food',
  'Food Court'
]

CATEGORIES.each do |category|
  Category.find_or_create_by!(name: category)
end
