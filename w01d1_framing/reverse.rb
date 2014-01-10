# stuart... you have got to be kidding me with this shoddy, unorganized, and 
# incomplete code. please see me in my office pronto.




puts "Enter a string"
str = gets.chomp

# Slice off the last letter and insert it in the right position
for i in (0...str.size)
	str.insert(i, str.slice!(-1))
end

puts str