def featured(num)
  new_num = num - num % 7
  loop do
    new_num += 7
    new_num_chars = new_num.to_s.chars
    if new_num.odd? && new_num_chars.uniq == new_num_chars
      return new_num
    elsif new_num_chars.size > 10
      return "ERROR: There is no possible number that fulfills those requirements"
    end
  end
end

puts featured(12) == 21
puts featured(20) == 21
puts featured(21) == 35
puts featured(997) == 1029
puts featured(1029) == 1043
puts featured(999_999) == 1_023_547
puts featured(999_999_987) == 1_023_456_987

puts featured(9_999_999_999) # -> There is no possible number that fulfills those requirements
