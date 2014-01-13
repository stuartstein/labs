require './animal'
require './client'
require './shelter'

shelter = Shelter.new("Happi Tails", "123 Happi Blvd, San Francisco, CA")


toys = ["ball", "laser pointer", "stuffed animal"]
shelter.animals.push(Animal.new("Annie", 5, "f", "dog", toys))
shelter.clients.push(Client.new("Clint", 2, 34))

shelter.animals.each { |a| puts a.age }
shelter.clients.each { |c| puts c.age }