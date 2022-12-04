class Pet
    def run
      'running!'
    end

    def jump
      'jumping!'
    end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def fetch
    'fetching!'
  end

  def swim
    'swimming!'
  end
end

class Cat < Pet
  def speak
    'meow!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

# teddy = Dog.new
# puts teddy.speak           # => "bark!"
# puts teddy.swim           # => "swimming!"
# spike = Bulldog.new
# puts spike.speak
# puts spike.swim
# sprinkles = Cat.new
# puts sprinkles.speak

pete = Pet.new
kitty = Cat.new
dave = Dog.new
bud = Bulldog.new

p pete.run                # => "running!"
# pete.speak              # => NoMethodError

p kitty.run               # => "running!"
p kitty.speak             # => "meow!"
# kitty.fetch             # => NoMethodError

p dave.speak              # => "bark!"

p bud.run                 # => "running!"
p bud.swim                # => "can't swim!"

# Pet
#   - run
#   - jump
#
#   > Dog
#     - speak
#     - fetch
#     - swim
#
#     > Bulldog
#       - swim
#
#   > Cat
#     - speak

# method lookup path is the list of possible locations of methods it will
# execute when the method name is called in order of precedence
# It will first look in its own class, then any modules starting with the
# last included and works up the hierarchy tree until it finds the method
# .ancestors class method shows the path
