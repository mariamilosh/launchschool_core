class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
  def initialize(name, age, color)
    super(name, age)
    @color = color
  end

  def to_s
    "My cat #{@name} is #{@age} years old and has #{@color} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch


# If the Pet class accepted the colors parameter, the initialize method in Cat
# would be unnecessary because a Cat object would inherit all of the parameters
# from the Pet class. It would make sense to modify Pet to include color since
# all pets have a color. If it was a trait that every pet didn't have then it
# wouldn't make sense to include it.
# If color isn't wanted for every pet, then it could be set as an optional
# parameter instead
# Changing the Pet class later on after it's in use and it has numerous
# subclasses could cause issues with dependency. Changing the number of
# parameters in a method could cause method errors.
