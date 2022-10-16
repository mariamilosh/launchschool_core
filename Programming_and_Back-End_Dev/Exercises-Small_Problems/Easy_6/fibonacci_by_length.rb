def find_fibonacci_index_by_length(num_digits)
  prev_num = 1
  num = 1
  total = 0
  index = 2
  while num.to_s.size < num_digits do
    total = num + prev_num
    prev_num = num
    num = total
    index += 1
  end
  index
end

puts find_fibonacci_index_by_length(2) == 7          # 1 1 2 3 5 8 13
puts find_fibonacci_index_by_length(3) == 12         # 1 1 2 3 5 8 13 21 34 55 89 144
puts find_fibonacci_index_by_length(10) == 45
puts find_fibonacci_index_by_length(100) == 476
puts find_fibonacci_index_by_length(1000) == 4782
puts find_fibonacci_index_by_length(10000) == 47847
