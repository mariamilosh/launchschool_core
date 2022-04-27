# numbers = [1, 2, 3, 4]
# numbers.each do |number|
#   p number
#   numbers.shift(1)
# end

# 1 3 because the array size is changing during iteration
# it skips 2 because it already iterated over index 0 and 3 is
# index 1

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end

# 1 2 because it removes the last value twice and then it can
# no longer iterate over those values
