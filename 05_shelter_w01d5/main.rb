require './animal'
require './client'
require './shelter'

def menu(message, shelter_name)

	puts `clear`
	puts "#{message}\n\n" unless message.empty?
	puts "Welcome to #{shelter_name}! Please select below:"
	puts
	puts "1 - Display all unadopted animals"
	puts "2 - Display all clients"
	puts "3 - Add an animal"
	puts "4 - Add a client"
	puts "5 - Register animal adoption"
	puts "6 - Register animal admission"
	puts "q - Quits the program"
	puts
	print "Enter your selection: "
	gets.chomp
end
	
shelter = Shelter.new("Happi Tails", "123 Happi Blvd, San Francisco, CA")
message = ""
looping = true

while looping
	choice = menu(message, shelter.name)
	puts
	case choice
		when "1"
			# Display the unadopted animals
			if shelter.unadopted_animals.empty?
				message = "Sorry, there are no animals available. Type '3' to add an animal."
			else
				message = "#{shelter.name}'s current animals:\n"
				shelter.unadopted_animals.each { |a| message += "#{a.display_info}\n" }
			end

		when "2"
			# Display all clients
			if shelter.clients.empty?
				message = "The shelter currently has no clients. Type '4' to add a client."
			else
				message = "#{shelter.name}'s current clients:\n"
				shelter.clients.each { |c| message += "#{c.display_info}\n" }
			end

		when "3"
			# Add a new animal in the shelter
			new_animal = shelter.create_animal
			
			# Give user feedback
			message = new_animal.display_info
			message += " has been added!"


		when "4"
			# Add a new client
			new_client = shelter.create_client
			
			# Give user feedback
			message = new_client.display_info
			message += " has been added!"

		when "5"
			if shelter.animals.empty?
				message = "Sorry, there are no animals available. Type '3' to add an animal."
			else
				# select the client
				puts "Let's start by selecting the client who will be adopting."
				selected_client = shelter.get_client()

				# select the animal
				puts "\nWhich animal will #{selected_client.name} be adopting?"
				selected_animal = shelter.choose_from_names(shelter.animals, "animal", shelter.name)

				# set animal owner to client, and add animal to client's pets
				selected_animal.owner = selected_client
				selected_client.pets.push(selected_animal) 

				message = "#{selected_animal.name} has been adopted by #{selected_client.name}."
			end

		when "6"
			# select the client
			puts "Let's start by selecting the client admitting the animal"
			selected_client = shelter.get_client()
			
			# select the animal to admit
			if selected_client.pets.empty?
				selected_pet = shelter.add_animal_anyway
			else
				selected_pet = shelter.choose_from_names(selected_client.pets, "pet", selected_client.name)
			end

			# if pet was selected, set owner to nil, and remove pet from owner
			if selected_pet == nil
				message = "No pets were added."
			else
				selected_client.pets.delete(selected_pet)
				selected_pet.owner = nil
				message = "#{selected_pet.name} has been admitted by #{selected_client.name}."
			end

		when "q"
			looping = false

		else
			"Your choice was invalid. Please try again."
		end
end