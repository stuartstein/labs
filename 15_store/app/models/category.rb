class Category < ActiveRecord::Base
	has_many :lookups
	has_many :products, through: :lookups
	

end
