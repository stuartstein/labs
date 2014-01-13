require './animal'
require './client'
require './shelter'

shelter = Shelter.new("Happi Tails", "123 Happi Blvd, San Francisco, CA")
toys = ["ball", "laser pointer", "stuffed animal"]
annie = Animal.new("Annie", 5, "f", "dog", toys)
clint = Client.new("Clint", 2, 34)

puts annie.age
puts clint.age