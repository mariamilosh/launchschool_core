# Input: array of arrays of integers
# Output: new array of arrays of integers
#
# matrix is represented by an array of arrays
# each inner array is a 'row' of the matrix
# 'columns' of the matrix are represented by the
# values at each index of the inner arrays
# ie all values at index 0 are a column,
# all values at index 1 are another column, and so on
#
# transposing the array puts the column values in the position
# of the row values and row values in the position of the column
# values
#
# Explicit requirements:
#   - modifiy transpose method
#   - switch columns and rows in matrix
#   - handle any matrix with at least 1 row and 1 column
#
# Implicit requirements:
#   - do not use Array#transpose method
#   - do not mutate input array
#
# Test cases:
#   transpose([[1, 2, 3, 4]]) == [[1], [2], [3], [4]]
#   transpose([[1], [2], [3], [4]]) == [[1, 2, 3, 4]]
#   transpose([[1, 2, 3, 4, 5], [4, 3, 2, 1, 0], [3, 7, 8, 6, 2]]) ==
#     [[1, 4, 3], [2, 3, 7], [3, 2, 8], [4, 1, 6], [5, 0, 2]]
#   transpose([[1]]) == [[1]]
#
# Algorithm:
#  - create a new array object prefilled with empty arrays for the
#    number of columns in the array
#  - iterate through the array:
#    within the iteration block, iterate through the
#    inner array with indexes:
#      at the index of the value of the inner array, add the value
#      to the array at the same index of the new array
#  - after iterations are complete, return new array
#
# define method with array parameter
# define new array prefilled with empty arrays for size of array[0]
# iterate each element of array
# => iterate each element of inner array with index
# => add inner array element to new array at index
# return new array

def transpose(arr)
  new_arr = Array.new(arr[0].size, [])

  arr.each do |a|
    a.each_with_index do |n, i|
      new_arr[i] += [n]
    end
  end
  new_arr
end

p transpose([[1, 2, 3, 4]]) == [[1], [2], [3], [4]]
p transpose([[1], [2], [3], [4]]) == [[1, 2, 3, 4]]
p transpose([[1, 2, 3, 4, 5], [4, 3, 2, 1, 0], [3, 7, 8, 6, 2]]) ==
  [[1, 4, 3], [2, 3, 7], [3, 2, 8], [4, 1, 6], [5, 0, 2]]
p transpose([[1]]) == [[1]]
