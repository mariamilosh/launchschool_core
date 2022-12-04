def reversed_number(num)
  rev_num = 0
  div_set = num.divmod(10)
  loop do
    rev_num = rev_num * 10 + div_set[1]
    break if div_set[0] == 0
    div_set = div_set[0].divmod(10)
  end
  rev_num
end

def reversed_number(num)
  rev_num_s = num.to_s.reverse
  rev_num = rev_num_s.to_i
end

puts reversed_number(12345) == 54321
puts reversed_number(12213) == 31221
puts reversed_number(456) == 654
puts reversed_number(12000) == 21 # No leading zeros in return value!
puts reversed_number(12003) == 30021
puts reversed_number(1) == 1
