puts 'Please enter a phrase to be framed'
words = gets.chomp.split(' ')

# find the longest word in the sentence
longest = 0
words.each { |w| longest = w.length if longest < w.length }

#output
puts
puts "Here it is left justified:"
puts "*" * (longest + 4) # add 4 to longest for padding — 2 on left right
words.each { |w| puts "* #{w.ljust(longest)} *"} # ljust aligns word left
puts "*" * (longest + 4)

puts
puts "Here it is centered:"
puts "*" * (longest + 4)
words.each { |w| puts "* #{w.center(longest)} *"} # center aligns word center
puts "*" * (longest + 4)


# comment by Bruce for Github exercise