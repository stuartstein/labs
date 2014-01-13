class Animal

attr_accessor :name, :age, :gender, :species

def initialize(name, age, gender, species, toys = [])
	@name = name
	@age = age
	@gender = gender
	@species = species
	@toys = toys
	@client = nil
end

def adopted?
	@client == nil ? true : false
end

end