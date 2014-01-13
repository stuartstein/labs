class Client

attr_accessor :name, :age, :kids_qty, :pets

def initialize(name, age, kids_qty)
	@name = name
	@kids_qty = kids_qty
	@age = age
	@pets = []
end

end