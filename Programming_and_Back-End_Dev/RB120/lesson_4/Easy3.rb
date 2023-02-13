puts "Question 1"

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

hello = Hello.new
hello.hi # => outputs "Hello"

hello = Hello.new
# hello.bye # => no method, #bye is not in the lookup chain for Hello

hello = Hello.new
# hello.greet # => wrong number of arguments

hello = Hello.new
hello.greet("Goodbye") # => outputs "Goodbye"

# Hello.hi # => no method. hi isn't a class method

puts "Question 2"

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def self.hi
    greeting = Greeting.new
    greeting.greet("Hello")
  end
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end
Hello.hi

puts "Question 3"

class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

bob = AngryCat.new(7, 'Bob')
p bob
bob.name
bob.age
larry = AngryCat.new(2, 'Larry')
p larry
larry.name
larry.age

puts "Question 4"

class Cat
  attr_reader :type

  def initialize(type)
    @type = type
  end

  def to_s
    "I am a #{type} cat"
  end
end

puts "Question 5"

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new
# tv.manufacturer # => no method error
tv.model # => calls instance method

Television.manufacturer # => calls class method
# Television.model # => no method error

puts "Question 6"

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    # self.age += 1
    @age += 1
  end
end

puts "Question 7"

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end

end


# self.information return since the last line is already returned





















#
