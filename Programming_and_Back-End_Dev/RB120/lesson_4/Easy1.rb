puts "Question 1"
# They are all objects
# #class method to find their class
p true.class
p "hello".class
p [1, 2, 3, "happy days"].class
p 142.class

puts ""
puts "Question 2"

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

Car.new.go_fast
Truck.new.go_fast

puts ""
puts "Question 3"
puts "self refers to the instance of the Car object (small_car) and class " \
     "refers to the class, which is Car"

puts ""
puts "Question 4"

class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end

angry_kitty = AngryCat.new
angry_kitty.hiss

puts "Question 5"

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

puts "Pizza has an instance variable, @name. Instance variables start with @"
# #instance_variables method called on an object returns the object's
# instance variables
puts "Question 6"
puts "calling #puts on an object automatically calls to_s on the object. " \
     "The default return value is the object's class name and object_id"

puts "Question 7"

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end
puts "self refers to the instance object. It is calling the accessor method for " \
"the @age instance variable. Otherwise it would create a new local variable " \
"called age."
puts "Question 8"
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

puts "self references the class, Cat, in the class method definition for " \
     "cats_count"

puts "Question 9"
class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

p bag = Bag.new('blue', 'plastic')
