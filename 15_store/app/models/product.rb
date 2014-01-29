class Product < ActiveRecord::Base
	has_many :lookups
	has_many :categories, through: :lookups

end
