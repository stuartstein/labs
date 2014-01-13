class Client

attr_accessor :name, :kids_qty, :age, :pets

def initialize(name, kids_qty, age, pets = [])
	@name = name
	@kids_qty = kids_qty
	@age = age
	@pets = pets
end

end