def move(n, from_array, to_array)
  return if n == 0
  to_array << from_array.shift
  move(n - 1, from_array, to_array)
end

# Example

todo = ['study', 'walk the dog', 'coffee with Tom']
done = ['apply sunscreen', 'go to the beach']

move(2, todo, done)

p todo # should be: ['coffee with Tom']
p done # should be: ['apply sunscreen', 'go to the beach', 'study', 'walk the dog']


# Error means that move method is stuck in a recursive loop
# There must be a condition that allows it to exit the recursion
# Fills up the 'stack' using more space than is allocated

# If from_array is smaller than n, to_array will contain nil values for each extra
# n value
