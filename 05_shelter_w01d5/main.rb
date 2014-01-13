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
	
happi = Shelter.new("Happi Tails", "123 Happi Blvd, San Francisco, CA")
message = ""
looping = true

while looping
	choice = menu(message, happi.name)
	puts
	case choice
		when "1"
			# Display the unadopted animals
			if happi.unadopted_animals.empty?
				message = "Sorry, there are no animals available. Type '3' to add an animal."
			else
				message = "#{happi.name}'s current animals:\n"
				happi.unadopted_animals.each { |a| message += "#{a.display_info}\n" }
			end

		when "2"
			# Display all clients
			if happi.clients.empty?
				message = "The shelter currently has no clients. Type '4' to add a client."
			else
				message = "#{happi.name}'s current clients:\n"
				happi.clients.each { |c| message += "#{c.display_info}\n" }
			end

		when "3"
			# Add a new animal in the shelter
			new_animal = happi.create_animal
			
			# Give user feedback
			message = new_animal.display_info
			message += " has been added!"


		when "4"
			# Add a new client
			new_client = happi.create_client
			
			# Give user feedback
			message = new_client.display_info
			message += " has been added!"

		when "5"
			if happi.animals.empty?
				message = "Sorry, there are no animals available. Type '3' to add an animal."
			else
				# select the client
				puts "Let's start by selecting the client who will be adopting."
				selected_client = happi.get_client()

				# select the animal
				puts "\nWhich animal will #{selected_client.name} be adopting?"
				selected_animal = happi.choose_from_names(happi.animals, "animal", happi.name)

				# set animal owner to client, and add animal to client's pets
				selected_animal.owner = selected_client
				selected_client.pets.push(selected_animal) 

				message = "#{selected_animal.name} has been adopted by #{selected_client.name}."
			end

		when "6"
			# select the client
			puts "Let's start by selecting the client admitting the animal"
			selected_client = happi.get_client()
			
			# select the animal to admit
			if selected_client.pets.empty?
				selected_pet = happi.add_animal_anyway
			else
				puts "Which pet will #{selected_client.name} be adopting?\n"
				selected_pet = happi.choose_from_names(selected_client.pets, "pet", selected_client.name)
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