def negative(num)
  num.to_s.match(/^(-|0)/) ? num : num * -1
end

puts negative(5) == -5
puts negative(-3) == -3
puts negative(0) == 0      # There's no such thing as -0 in ruby
puts negative(60) == -60

def negative(num)
  num.negative? ? num : num * -1
end

puts negative(5) == -5
puts negative(-3) == -3
puts negative(0) == 0      # There's no such thing as -0 in ruby
puts negative(60) == -60
