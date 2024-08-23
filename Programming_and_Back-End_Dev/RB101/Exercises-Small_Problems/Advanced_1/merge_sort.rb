# Input: array of integers
# Output: new array of integers
#
# Sort array using merge sort with data of either all numbers or all strings
# Break array down into nested sub-arrays then sort and recombine them
#
# Explicit requirements:
# - Break array into nested sub-arrays
# - Use recursion
# - combine nested sub-arrays in sorted order
#
# Implicit requirements:
# - do not mutate input array
# - use merge method to combine sorted sub-arrays
#
# Start by dividing array into two sub-arrays
# Divide first of two sub-arrays into two sub-arrays
# Continue until each sub-array has 1 value
# Use merge to combine innermost sub-array

# def partition(arr)
#   arr1 = arr.first(arr.size/2)
#   [arr1, arr.last(arr.size - arr1.size)]
# end

# Returns an new array containing input array divided into two equally sized
# arrays. (Odd size arrays divided into two almost equal size arrays)
def partition(arr)
  [arr.first(arr.size / 2 + arr.size % 2), arr.last(arr.size / 2)]
end

# takes an array of non-array items and divides it into an array of
# two arrays recursively until the inner-most arrays each contain only
# one item
def divide_arr(arr)
  return arr if arr.size == 1
  new_arr = partition(arr)
  new_arr.map do |i|
    divide_arr(i)
  end
end

# merges a 2 dimensional array of arrays into a one-dimensional array with
# elements in order by value from low to high
def merge(arr)
  new_array = []
  arr0 = arr[0].dup
  arr1 = arr[1].dup
  loop do 
    break if arr0.empty? && arr1.empty?
    case arr0[0] <=> arr1[0]
    when 1
      new_array << arr1.shift
    when -1
      new_array << arr0.shift
    when 0
      new_array << arr0.shift
      new_array << arr1.shift
    else
      new_array += arr0.shift(arr0.size) + arr1.shift(arr1.size)
    end
  end
  new_array.compact
end

# Divides array into 2 sub arrays recursively until lowest-level arrays contain
# one element
# Recursively combines arrays starting with lowest-level arrays in sorted order
# from low to high values
def merge_sort(arr)
  arr = divide_arr(arr) if arr.map(&:class).none? { |c| c == Array }
  new_arr = arr.map do |el|
    el.map(&:class).none? { |c| c == Array } ? el : merge_sort(el)
  end
  merge(new_arr)
end

p merge_sort([9, 5, 7, 1]) == [1, 5, 7, 9]
p merge_sort([5, 3]) == [3, 5]
p merge_sort([6, 2, 7, 1, 4]) == [1, 2, 4, 6, 7]
p merge_sort(%w(Sue Pete Alice Tyler Rachel Kim Bonnie)) == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)
p merge_sort([7, 3, 9, 15, 23, 1, 6, 51, 22, 37, 54, 43, 5, 25, 35, 18, 46]) == [1, 3, 5, 6, 7, 9, 15, 18, 22, 23, 25, 35, 37, 43, 46, 51, 54]

# # *************************************
# # LaunchSchool Solution:

# def merge(array1, array2)
#   index2 = 0
#   result = []

#   array1.each do |value|
#     while index2 < array2.size && array2[index2] <= value
#       result << array2[index2]
#       index2 += 1
#     end
#     result << value
#   end

#   result.concat(array2[index2..-1])
# end

# def merge_sort(array)
#   return array if array.size == 1

#   sub_array_1 = array[0...array.size / 2]
#   sub_array_2 = array[array.size / 2...array.size]

#   sub_array_1 = merge_sort(sub_array_1)
#   sub_array_2 = merge_sort(sub_array_2)

#   merge(sub_array_1, sub_array_2)
# end
# # *************************************
