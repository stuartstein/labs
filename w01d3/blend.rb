# Instructions are written inline.
 
# docs you may enjoy
# http://www.ruby-doc.org/core-2.0/Hash.html
# http://ruby-doc.org/core-2.0/String.html
# http://ruby-doc.org/core-2.0/Array.html
 
# Every Morning I make a smoothie with the follow ingredients:
smoothie_ingredients = {
  'flax seeds' => '1 tbsp',
  'chia seeds' => '1 tbsp',
  'coconut flakes' => '1 tbsp',
  'spirulina' => '1 tsp',
  'pumpkin seeds' => '1 tbsp',
  'oatmeal' => '1/4 cup',
  'coco powder' => '1 tbsp',
  'peanut butter' => '1 tbsp',
  'almonds' => '1/4 cup',
  'walnuts' => '1/4 cup',
  'spinach' => '1/4 cup',
  'greek yogurt' => '1/4 cup',
  'nutrional yeast' => '1 tbsp',
  'brussel sprouts' => '1/4 cup',
  'asparagus' => '1/4 cup',
  'kale' => '1/4 cup',
  'brocoli rabe' => '1/4 cup',
  'blue berries' => '1/4 cup',
  'chopped banana' => '1/2 cup',
  'straw berries' => '1/4 cup',
  'mango' => '1/4 cup',
  'hemp milk' => '1 cup'
}
 

 # Write a function called blend.
# It should take all the smoothie ingredients (not the measurements) and chop up and mix all the characters
# and output a mixed string of characters
# Be sure to remove the spaces, as we don't want any air bubbles in our smoothie!
  
# create a class called Blender
# It should have a method that takes an array of ingredients and returns a mixed string of characters.
# Give the blender an on and off switch and only allow the blender to function when it's on.
# FOR SAFETY'S SAKE When you create a new blender by default it should be off.
# Blend the the smoothie array
 
class Blender

attr_reader :power

def initialize(power="off")
  
  @power = power

end


def blend(smoothie_ingredients)
  
  if @power == "off"

    puts "First, we have to turn on the power!"
    switch_power("on") 

  end
  
  # blend up the words to make our liquid smoothie
  puts "We're blending!"
  key_str = smoothie_ingredients.keys.join
  liquid = key_str.delete(" ").split("")
  liquid.shuffle    
end


def switch_power(state)

  puts "To turn #{state} the blender, type '#{state}'"
  answer = gets.chomp
  
  until answer == state  

    puts "Try again. To turn #{state} blender, type '#{state}'"
    answer = gets.chomp

  end
  
  @power = state

end


def pour(liquid)
  
  # turn off power
  if @power == "on"
  
    puts "Before we can pour our smoothie, turn off the blender!"
    switch_power("off") 
  
  end
  
  beg = 0
  fin = 1
  i = 1

  # find how many layers are in the glass (var i)
  until (beg..fin).include?(liquid.size)
 
    i +=1
    beg = fin
    fin += i
 
  end

  # top of the liquid may be less than size of top layer. Find liquid size.
  liquid_surface = liquid.size - beg
  top_length = i
  
  # output the first line of the liquid
  line = pour_line(liquid_surface, liquid)
  puts "* #{line.center(top_length + 3)} *" 

  # output the rest of the liquid
  until i == 1
    i -= 1
    line = pour_line(i, liquid)   
    puts "* #{line} *".center(top_length + 8) 
  end

  # output bottom of cup
  puts "***".center(top_length + 8)

  # output stem
  for j in (0..7)
    puts "*".center(top_length + 8)
  end

  # output base
  puts "*****************".center(top_length + 8)
end

def pour_line(len, liquid)

  output = ""
  
  for j in (1..len)
    output << liquid.pop
  end
  
  output

end

end

blendie = Blender.new()
liquid = blendie.blend(smoothie_ingredients)
blendie.pour(liquid)
