class Shelter

attr_accessor :name, :address, :animals, :clients

def initialize(name, address)
	@name = name
	@address = address
	@animals = []
	@clients = []
	
end

def create_animal

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
	
	# Create a new animal and add to animal list
	@animals.push(Animal.new(name, age, gender, species, toys))
	@animals[-1]

end

def create_client

	# Enter client info
	puts "Please enter the client's information."
	print "Client name: "
	name = gets.chomp
	print "Client age: "
	age = gets.to_i
	print "Number of children: "
	kids_qty = gets.to_i
			
	# Create a new client and add to client list
	@clients.push(Client.new(name, age, kids_qty))
	@clients[-1]

end


def choose_from_names(list, label, owner)

	# put names in an array and print them
	names = list.map { | i | i.name }
	looping = true
	puts "\n#{owner}'s current #{label}s: "
	names.each { | n | puts n }

	# ask user to enter a name from the list
	while looping	
		puts "\nEnter a name from the list above: "
		choice = gets.chomp
	 	names.include?(choice) ? looping = false : puts("\nThat name is not included.")
	end

	# return the object associated with that name
	(list.select { | a | a.name == choice }).first

end



def get_client

	looping = true

	# Ask whether client is new or existing
	while looping
		puts "Is the client new or existing?" 
		puts "Type ('n' for 'new' and 'e' for existing)"
		choice = gets.chomp
		(choice == 'n' || choice == 'e') ? looping = false : puts("Try again.")
	end

	# if client's new, create client. Otherwise choose from existing clients.
	choice == 'n' ? create_client : choose_from_names(@clients, "client", @name)
end

def add_animal_anyway

	looping = true

	# Ask if we want to add a pet that's not registered to the client
	while looping
		puts "This client has no registered pets. Would you like to add a new animal anyway? (y / n)"
		choice = gets.chomp
		(choice == "y" || choice == "n") ? looping = false : puts("Try again.")
	end
	choice == "y" ? create_animal : nil

end

def unadopted_animals
	@animals.select { |a| !a.adopted? }
end

end
