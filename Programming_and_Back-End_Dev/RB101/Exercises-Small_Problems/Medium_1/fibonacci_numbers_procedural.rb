def fibonacci(num)
  return 1 if num <= 2
  prev_num = 1
  curr_num = 1
  total = 0
  (num - 2).times do
    total = curr_num + prev_num
    prev_num = curr_num
    curr_num = total
  end
  curr_num
end

puts fibonacci(2)
puts fibonacci(3)
puts fibonacci(4)
puts fibonacci(5)
puts fibonacci(20) == 6765
puts fibonacci(100) == 354224848179261915075
puts fibonacci(100_001) # => 4202692702.....8285979669707537501
