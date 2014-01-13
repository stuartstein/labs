require './animal'
require './client'
require './shelter'

def menu(message, shelter_name)
	puts `clear`
	puts message
	puts
	puts "Welcome to #{shelter_name}! Please select below:"
	puts
	puts "1 - Add an animal"
	puts "2 - Add a client"
	puts "q - Quits the program"
	puts
	print "Enter your selection: "
	gets.chomp
end

shelter = Shelter.new("Happi Tails", "123 Happi Blvd, San Francisco, CA")

menu_loop = true
message = ""

while menu_loop
	choice = menu(message, shelter.name)
	puts
	case choice
		when "1"
			# Enter animal information
			puts "Please enter the animal's information."
			print "Animal name: "
			name = gets.chomp
			print "Animal age: "
			age = gets.to_i
			print "Animal gender: "
			gender = gets.chomp
			print "Animal species: "
			species = gets.chomp
			print "Animal's toys (separated by commas): "
			toys = gets.chomp.split(", ")
			
			# Create a new animal in the shelter
			shelter.animals.push(Animal.new(name, age, gender, species, toys))
			
			# Give user feedback
			selected_animal = (shelter.animals.select { |a| a.name == name }).first
			message = "#{selected_animal.name} (age: #{selected_animal.age}, gender: #{selected_animal.gender}, species: #{selected_animal.species}) has been added!"

		when "2"
			# Enter client info
			puts "Please enter the client's information."
			print "Client name: "
			name = gets.chomp
			print "Client age: "
			age = gets.to_i
			print "Number of children: "
			kids_qty = gets.to_i
			
			# Create a new client for the shelter
			shelter.clients.push(Client.new(name, age, kids_qty))
			
			# Give user feedback
			selected_client = (shelter.clients.select { |c| c.name == name }).first
			message = "#{selected_client.name} (age: #{selected_client.age}, kids: #{selected_client.kids_qty}) has been added!"
		when "q"
			menu_loop = false
		else
			"Your choice was invalid. Please try again."
	end
end

shelter.animals.each { |a| puts a.age }
shelter.clients.each { |c| puts c.age }