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
# Divide second of previous level sub-arrays into two sub-arrays
# Continue until each sub-array has 1 value
# Continue moving up and down the chain of sub-arrays until all sorted
#   sub-arrays are combined
#
# Pseudocode:
#
# define merge_sort method and accept array as argument
# initialize new_array
# loop
# if array size > 1
# => sub-array 1 = array index 0 through array size divided by 2
# => sub-array 2 = array size divided by 2 through array index -1
# =>
# else
# =>
# return new_array
#
#



def divide_array(arr)
  new_arr = arr.dup
  if arr.size > 1
    # new_arr = [arr[0...arr.size/2], arr[arr.size/2..-1]]
    new_arr = [arr[0, (arr.size/2.0).ceil],
               arr[(arr.size/2.0).ceil, arr.size - 1]]
    new_arr[0] = divide_array(new_arr[0])
    new_arr[1] = divide_array(new_arr[1])
  end
  new_arr
end
# use dig
# try_convert -> returns nil if object is already array
# val = []
# do
def combine_array(arr)
  new_arr = arr.dup

  new_arr.each do |a|
    if a[0].try_convert
      return merge(new_arr[0], new_arr[1])
    else
      new_arr = combine_array(a)
    end
  end
  new_arr

end

def merge_sort(arr)
  new_arr = divide_array(arr)

end

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



p merge_sort([9, 5, 7, 1])
# == [1, 5, 7, 9]
p merge_sort([5, 3]) == [3, 5]
p merge_sort([6, 2, 7, 1, 4]) == [1, 2, 4, 6, 7]
p merge_sort(%w(Sue Pete Alice Tyler Rachel Kim Bonnie)) == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)
p merge_sort([7, 3, 9, 15, 23, 1, 6, 51, 22, 37, 54, 43, 5, 25, 35, 18, 46]) == [1, 3, 5, 6, 7, 9, 15, 18, 22, 23, 25, 35, 37, 43, 46, 51, 54]
