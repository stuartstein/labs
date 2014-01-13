puts "Guess a number between 1 and 100"

# initialize variables
answer = rand(1..100)
tries = 0
found = false

until  found
	
	# Get people's guesses
	guess = gets.to_i
	tries += 1

	if answer > guess
		puts "The number is higher than #{guess}. Guess again."
	elsif answer < guess
		puts "The number is lower than #{guess}. Guess again."
	else
		puts "You got it in #{tries} tries!"
		found = true
	end

end
