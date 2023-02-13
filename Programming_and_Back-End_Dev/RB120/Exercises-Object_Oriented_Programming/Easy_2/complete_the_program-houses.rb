class House
  include Comparable
  attr_reader :price

  def initialize(price)
    @price = price
  end

  def <=>(other)
    price <=> other.price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1

# Using Comparable here is a good idea if price is the only value in the class
# that needs to be compared. There are other variables like number of bedrooms,
# property taxes, acreage, etc. that may also be worth comparing.
# In order to compare specific variables, calling the accessor methods for the 
# variables would make more sense
