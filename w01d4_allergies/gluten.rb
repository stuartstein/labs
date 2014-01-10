#Title: Gluten Free
 
#Prerequisites:
#- Ruby
#    - Exceptions
#    - Hashes & Arrays
#    - Objects & Classes
 
#Objectives:
#- Work with exceptions, classes, class variables, conditions
 
"======================================================================"
 
# Create a Person class. A person will have a stomach and allergies
# Create a method that allows the person to eat and add arrays of food to their stomachs
# If a food array contains a known allergy reject the food.
 
class Person

	def initialize(name, allergies)
		@name = name
		@stomach = []
		@allergies = allergies

	end

	def eat(foods)

		begin

			foods.each do | f |
				
				# The person unwittingly eats the food!
				@stomach.push(f) 

				# if allergies is String, convert to array 
				# it helps with the include statement!
				allergy_arr = []
				@allergies.is_a?(String) ? allergy_arr[0] = @allergies : allergy_arr = @allergies

				if allergy_arr.include?(f)
					
					raise AllergyError.new(f)
				end

			end

		rescue AllergyError => food 

			puts "Sorry, #{@name} is allergic to #{food}"
			vomit()
			puts

		end
	end
	def vomit()

		unless @stomach.empty?

			output = "#{@name} is vomiting "
			
			for i in (0...@stomach.size)
				output << "#{@stomach.pop}, "
			end
			puts output.slice!(0..output.size - 3) 
			
		
		else
			"#{name}'s stomach is empty"
		end

	end

end

class AllergyError < ArgumentError

end

 
# Create a Person named Chris. Chris is allergic to gluten.
# Create a Person named Beth. Beth is allergic to scallops.
# Feed them the following foods
 
pizza = ["cheese", "gluten", "tomatoes"]
pan_seared_scallops = ["scallops", "lemons", "pasta", "olive oil"]
water = ["h", "h", "o"]
meal = [pizza, pan_seared_scallops, water]

chris = Person.new("Chris", "gluten")
beth = Person.new("Beth", "scallops")

meal.each do |m|

	chris.eat(m)
	beth.eat(m)

end


 
# When a person attempts to eat a food they are allergic to, raise a custom exception
# For example:  AllergyError
 
 
# Bonus: When a person attempts to eat a food they are allergic to,
#  ... remove ALL the food from the person's stomach before raising the exception