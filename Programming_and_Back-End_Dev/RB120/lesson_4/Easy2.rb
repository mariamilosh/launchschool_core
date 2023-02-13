puts "Question 1"

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

oracle = Oracle.new # => new Oracle object, oracle, is instantiated
p oracle.predict_the_future # => returns a string "You will " and a
                          # random string from the array in the choices
                          # method
puts "Question 2"
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

trip = RoadTrip.new
p trip.predict_the_future # => returns string "You will <something>" with
                        # something being a string from the array in the
                        # RoadTrip #choices method

puts "Question 3"

module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

p Orange.ancestors
p HotSauce.ancestors

# calling the #ancestors on a class shows the lookup chain
# Orange is Orange, Taste, Object, Kernel, BasicObject
# HotSauce is HotSauce, Taste, Object, Kernel, BasicObject

puts "Question 4"

class BeesWax
  attr_accessor :type
  def initialize(type)
    @type = type
  end

  # def type
  #   @type
  # end
  #
  # def type=(t)
  #   @type = t
  # end

  def describe_type
    puts "I am a #{type} of Bees Wax"
  end
end

BeesWax.new("honey").describe_type

puts "Question 5"

excited_dog = "excited dog" # => local variable. no leading '@'
# @excited_dog = "excited dog" # => instance variable, one leading '@'
# @@excited_dog = "excited dog" # => class variabl, two leading '@'

puts "Question 6"

class Television
  def self.manufacturer # => class method
    # method logic
  end

  def model
    # method logic
  end
end

Television.manufacturer # => call on the class rather than the object

puts "Question 7"

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

puts "Creates a class variabl called @@cats_count that is incremented by one " \
"every time a Cat object is declared. The value can be called with Cat.cats_count"
Cat.new('calico')
Cat.new('tabby')
Cat.new('black')
puts Cat.cats_count

puts "Question 8"

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

# make Bingo a child of Game so it inherits its methods

puts "Question 9"

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end

  def play
    "Let's play Bingo!"
  end
end

puts Bingo.new.play

# It will use the first method it finds in its lookup chain


puts "Question 10"

# Namespacing, modulating code, templating to remove duplication,
# readability, easier to share code for others to use, manage complexity,
# faster coding, thinking abstractly, easier to conceptualize









#
