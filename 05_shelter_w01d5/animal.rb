class Animal

attr_accessor :name, :age, :gender, :species, :owner

def initialize(name, age, gender, species, toys = [])
	@name = name
	@age = age
	@gender = gender
	@species = species
	@toys = toys
	@owner = nil
end

def adopted?
	@owner != nil
end

def display_info
	toy_str = @toys.inject("") {|str, toy| str + toy + ", "}.slice(0...-2)
	"#{@name} (age: #{@age}, gender: #{@gender}, species: #{@species}, toys: #{toy_str})"
end

end