class Client

attr_accessor :name, :age, :kids_qty, :pets

def initialize(name, age, kids_qty)
	@name = name
	@kids_qty = kids_qty
	@age = age
	@pets = []
end

def display_info
	pet_str = 
	@pets.empty? ? "none" : @pets.inject("") {|str, pet| str + pet.name + ", "}.slice(0...-2)
	"#{@name} (age: #{@age}, kids: #{@kids_qty}, pets: #{pet_str})"
end

end