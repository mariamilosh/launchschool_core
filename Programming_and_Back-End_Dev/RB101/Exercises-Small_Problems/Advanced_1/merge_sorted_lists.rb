# input: two arrays of integers
# output: a new array of integers
#
# input arrays are in ascending order
# output array must combine arrays so they are also
# in ascending order without sorting them
#
# Explicit requirements:
#   - combine two arrays in sorted order
#   - do not use #sort method
#   - do not mutate input arrays
#   - build result array one element at a time in order
#
# Implicit requirements:
#   - store values in new array object
#   - be able to handle empty arrays
#   - be able to compare/store duplicate integers
#
# Test cases:
#   merge([1, 5, 9], [2, 6, 8]) == [1, 2, 5, 6, 8, 9]
#   merge([1, 1, 3], [2, 2]) == [1, 1, 2, 2, 3]
#   merge([], [1, 4, 5]) == [1, 4, 5]
#   merge([1, 4, 5], []) == [1, 4, 5]
#
# Algorithm:
#
# create new array objects equal to each each input array
# define new array
# remove first element of each array copy and store in variable
# start loop while at least one first element variable is not nil
# check if one variable is nil to leave the loop early
# => if nil, make array of min values followed by remaining values in input
# => array copies
# => use select to choose non nil values in array of remaining vlaues and add to
# => new array
# => return the new array
# check if one minimum value is less than or equal to the other
# => if less than, add that minimum value to the end of new array
# => remove next first value in the copied array and store it in the minimum
# => value variable
# if neither of the previous two conditionals are true, store the other minimum
# value in the new array and get new minimum value from copied array
# exit loop once both arrays are empty
# return new array

# define input array copies
# define new empty array object
# initialize minimum integer variable to first int in first input array
# initialize minimum integer variable to first int in second input array
# while loop
# continue while either of the minimum integer variables are not nil
# if statement -> either minimum integer variable is nil
# => combine variables into an array
# =>    [array1_min, array2_min] | array1_copy | array2_copy
# =>    select every value that is truthy (not nil)
# => add array to end of new array
# => return new array
# elsif statement -> array1_min is less than or equal to array2_min
# => add array1_min to end of new_array
# => store next first integer from array1_copy into array1_min
# else
# => add array2_min to end of new_array
# => store next first integer from array2_copy into array2_min
# end while loop
# return new array

def merge(arr1, arr2)
  arr1_cpy = arr1.dup
  arr2_cpy = arr2.dup
  new_arr = []
  arr1_min = arr1_cpy.shift
  arr2_min = arr2_cpy.shift
  while arr1_min || arr2_min do
    if !arr1_min || !arr2_min
      new_arr += ([arr1_min, arr2_min] | arr1_cpy | arr2_cpy).select { |n| n }
      return new_arr
    elsif arr1_min <= arr2_min
      new_arr << arr1_min
      arr1_min = arr1_cpy.shift
    else
      new_arr << arr2_min
      arr2_min = arr2_cpy.shift
    end
  end
  new_arr
end

p merge([1, 5, 9], [2, 6, 8])
# == [1, 2, 5, 6, 8, 9]
p merge([1, 1, 3], [2, 2]) == [1, 1, 2, 2, 3]
p merge([], [1, 4, 5]) == [1, 4, 5]
p merge([1, 4, 5], []) == [1, 4, 5]


# two arrays
#
# compare first digit in both arrays
# put smallest digit at end of new array
