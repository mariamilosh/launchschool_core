def digit_list(num)
  num_size = num.to_s.size
  digits = (1..(num_size)).map do |i|
    (num % (10**i))/(10**(i-1))
  end
  digits.reverse
end

# def digit_list(num)
#   num.digits.reverse
# end

puts digit_list(12345) == [1, 2, 3, 4, 5]     # => true
puts digit_list(7) == [7]                     # => true
puts digit_list(375290) == [3, 7, 5, 2, 9, 0] # => true
puts digit_list(444) == [4, 4, 4]             # => true
