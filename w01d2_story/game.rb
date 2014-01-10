# prints individual pages and path
def output(current_page, pages, breadcrumbs)
	
	# prints the path/trail of where you've been
	puts
	trail = ""
	breadcrumbs.each { |b| trail << "#{b} > " }
	puts "{ #{trail.slice(0, trail.length-3)} }"
	puts
	
	# output page
	page = pages.select {|k,v| k.include?("~#{current_page}")}
	page.each {|k,v| puts v}

end

# returns number of choices for a key
def num_of_choices(current_page, pages)
	choices = 0
	pages.select { |k,v| choices += 1 if k.include?("~#{current_page}:c")}
	choices
end

# returns next page, depending on their choice
def find_next_page(choice, current_page, pages)
	key = ""
	pages.select {|k,v| key = k if k.include?("~#{current_page}:c#{choice}")}
	indicator = key.split(":")
	indicator[2]
end


# initialize our hash
pages = {}

# Read in story.txt into a hash called pages
File.open("story.txt", "r") do |infile|

  while (line = infile.gets)
  	
  	if line.include? "~p"
  		k = line.chomp
  		pages[k] = ""

  	else
  		pages[k] += line
  	end

  end

end

# initialize more variables 
breadcrumb = []
restart = "y"
current_page = "p1"

# keep running the program until someone chooses to stop (not restart)
while restart.downcase == "y" || restart.downcase == "yes"

	# output the current page 
	breadcrumb.push(current_page)
	output(current_page, pages, breadcrumb)

	# determine how many choices are on the page
	c = num_of_choices(current_page, pages)


	# if page has choices, then pick choice, otherwise, ask to restart
	if c > 0

		# ask for choice (and make sure it's valid!)
		continue = false
		until continue

			# if they're not on the first page, ask if they want to go back
			if current_page == "p1" 
				puts "Pick a number 1 through #{c}"
			else
				puts "Pick a number 1 through #{c}, or type 'back' to go back"
			end

			choice = gets.chomp

			continue = true if (choice.downcase == "back" && current_page != "p1") || choice.to_i.between?(1,c)

		end

		# set current page to the page you want to go to next 
		if choice.downcase == "back" 
			breadcrumb.pop 
			current_page = breadcrumb.pop
		else
			current_page = find_next_page(choice, current_page, pages)
		end

	else
		# ask them if you they want to play again
		puts
		puts "Wanna play again? (y/n)"
		restart = gets.chomp
		current_page = "p1"
		puts
	end

end