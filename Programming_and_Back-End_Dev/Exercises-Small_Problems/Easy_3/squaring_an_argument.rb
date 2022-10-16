def multiply(num1, num2)
  num1 * num2
end

def square(num)
  multiply(num, num)
end

def exponent(num, power)
  total = 1
  power.times do
    total = multiply(num, total)
  end
  total
end

puts square(5) == 25
puts square(-8) == 64

puts exponent(2, 3)
puts exponent(-2, 3)
puts exponent(-3, 2)
