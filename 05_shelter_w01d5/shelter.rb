class Shelter

attr_accessor :name, :address, :animals, :clients

def initialize(name, address)
	@name = name
	@address = address
	@animals = []
	@clients = []
	
end

end