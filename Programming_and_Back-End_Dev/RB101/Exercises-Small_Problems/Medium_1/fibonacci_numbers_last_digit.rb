# def fibonacci(num)
#   return 1 if num <= 2
#   prev_num = 1
#   curr_num = 1
#   total = 0
#   (num - 2).times do
#     total = curr_num + prev_num
#     prev_num = curr_num
#     curr_num = total
#   end
#   curr_num
# end

def fibonacci_last(num)
  # fibonacci(num).to_s[-1].to_i
  # fibonacci(num).digits[-1]
  # fib_num = fibonacci(num)
  # fib_num % 10
  # Only need the last digit of each fib number

  last_nums = [1, 1]
  3.upto(num) do
    last_nums = [last_nums.last, (last_nums.first + last_nums.last) % 10]
  end
  last_nums.last
end

puts fibonacci_last(15)        # -> 0  (the 15th Fibonacci number is 610)
puts fibonacci_last(20)        # -> 5 (the 20th Fibonacci number is 6765)
puts fibonacci_last(100)       # -> 5 (the 100th Fibonacci number is 354224848179261915075)
puts fibonacci_last(100_001)   # -> 1 (this is a 20899 digit number)
# puts fibonacci_last(1_000_007) # -> 3 (this is a 208989 digit number)
# puts fibonacci_last(123456789) # -> 4
# (1..30).each do |num|
#   puts "#{num}, #{fibonacci_last(num)}"
# end

# patterns:
# odd odd even
# golden ratio
# 1.618 = (a + b) / a = a / b = 1.618
# Binet's Formula
# X = (g^n - (1-g)^n)/ sqrt(5)
