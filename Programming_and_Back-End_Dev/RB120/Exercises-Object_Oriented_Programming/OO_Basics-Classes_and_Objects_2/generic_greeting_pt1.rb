class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

Cat.generic_greeting

kitty = Cat.new
# kitty.generic_greeting # => undefined method `generic_greeting' for #<Cat:0x007fbdd3875e40> (NoMethodError)
kitty.class.generic_greeting
# #class makes the method call reference the class rather than the object so
# it's the same as calling Cat.generic_greeting
