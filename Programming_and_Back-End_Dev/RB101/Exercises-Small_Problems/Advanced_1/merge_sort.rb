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



# def divide_array(arr)
#   new_arr = arr.dup
#   if arr.size > 1
#     # new_arr = [arr[0...arr.size/2], arr[arr.size/2..-1]]
#     new_arr = [arr[0, (arr.size/2.0).ceil],
#                arr[(arr.size/2.0).ceil, arr.size - 1]]
#     new_arr[0] = divide_array(new_arr[0])
#     new_arr[1] = divide_array(new_arr[1])
#   end
#   new_arr
# end
# # use dig
# # try_convert -> returns nil if object is already array
# # val = []
# # do
# def combine_array(arr)
#   new_arr = arr.dup

#   new_arr.each do |a|
#     if a[0].try_convert
#       return merge(new_arr[0], new_arr[1])
#     else
#       new_arr = combine_array(a)
#     end
#   end
#   new_arr

# end

# def merge_sort(arr)
#   new_arr = divide_array(arr)

# end

# def merge(arr1, arr2)
#   arr1_cpy = arr1.dup
#   arr2_cpy = arr2.dup
#   new_arr = []
#   arr1_min = arr1_cpy.shift
#   arr2_min = arr2_cpy.shift
#   while arr1_min || arr2_min do
#     if !arr1_min || !arr2_min
#       new_arr += ([arr1_min, arr2_min] | arr1_cpy | arr2_cpy).select { |n| n }
#       return new_arr
#     elsif arr1_min <= arr2_min
#       new_arr << arr1_min
#       arr1_min = arr1_cpy.shift
#     else
#       new_arr << arr2_min
#       arr2_min = arr2_cpy.shift
#     end
#   end
#   new_arr
# end

def partition(arr)
  arr1 = arr.first(arr.size/2)
  [arr1, arr.last(arr.size - arr1.size)]
end

def partition(arr)
  [arr.first(arr.size / 2 + arr.size % 2), arr.last(arr.size / 2)]
end

# takes an array of non-array items and divides it into an array of
# two arrays recursively until the bottommost arrays each contain only
# one item
def divide_arr(arr)
  return arr if arr.size == 1
  new_arr = partition(arr)
  new_arr.map do |i|
    divide_arr(i)
  end
end

# dig at each index of array and step down one level if item at
# that index is still array class instead of int or string
# arr with single non-array item is an item to sort. If neighboring
# arr is not also a single non-array item, then it needs to be
# divided 
def combine_arr(arr)
  # return arr if arr.size > 1
  # arr[0].size
  sorted_arr = []
  arr.map do |item|
    if item.class == Array
      # item.each do |idx|
      if item.size == 1 && item.dig(0).class != Array

      else
        # combine_arr(divide_arr(item))
      end
      # combine_arr(item)
      # end
    # else
    #   item
    end
  end
end

def combine_arr(arr)
# start with nested subarrays
# check if nested arrays are size 1 and element is array
#   compare nested array elements and put them in order
#   return ordered array
# check if nested arrays
  # arr.map(&:class).each { |c| puts c == Array }
  # arr.map(&:class).all? { |c| c == Array }
  new_arr = []
  arr.each do |el|
    # combine_arr(el) unless el.size == 1 && el.dig(0).class != Array
    # print el
    combine_arr(el) if el.map(&:class).all? { |c| c == Array }
    print el
    puts ""
    case el[0] <=> el[1]
    when 1
      new_arr += [el[1] + el[0]]
      # print new_arr
    when -1 || 0
      new_arr += [el[0] + el[1]]
      # print new_arr
    # else
      
    end
  end
  # print arr
  # puts ""
  new_arr
end

# [[[[[9], [6]], [2]], [[7], [6]]], [[[8], [5]], [[0], [1]]]]
# dig until it's an array of integers
# integers need to be one step below enumerable
def combine_arr(arr)
  new_arr = []
  arr.map do |el|
    # combine_arr(el) unless el.size == 1 && el.dig(0).class != Array
    # combine_arr(el) if el.map(&:class).all? { |c| c == Array }
    # el.map do |sub_el|
    #   print sub_el
    #   puts ""
    #   unless sub_el.map(&:class).all? { |c| c == Integer }
    #     combine_arr(el)
    #   end
    # end
    
    unless el.map(&:class).all? { |c| c != Array }
      combine_arr(el)
    # else
    #   print el
    #   puts ""
    end

    # unless el.map(&:class).all? { |c| c == Integer }
    #   combine_arr(el)
    # end

      # print el.map(&:class)
      # puts ""
      # print el
      # puts ""
    
    
    # print el if el.map(&:class).all? { |c| c == Array }
    # puts "" if el.map(&:class).all? { |c| c == Array }
    # puts el.map { |sub_el| sub_el.map(&:class).all? { |c| c != Array } }
    
    
    
    # if el.size == 1 && el.dig(0).class != Array
    #   # print el
    #   # puts ""
    # elsif el.map(&:class).all? { |c| c == Array }
    #   # print el if el.map { |sub_el| sub_el.class }.all? { |c| c == Integer }
    #   el.map do |sub_el| 
    #     # print sub_el.map{ |r| r}
    #     # puts ""
    #     # combine_arr(sub_el) unless sub_el.map(&:class).all? { |c| c == Array }
    #     print sub_el if sub_el.map(&:class).all? { |c| c == Array }
    #     puts ""
    #   end
    #   # puts ""
    #   puts ""
    #   # puts false
    # end
  end
  # if 
  case arr[0] <=> arr[1]
  when 1
    new_arr += [arr[1] + arr[0]]
    # print new_arr
  when -1 || 0
    new_arr += [arr[0] + arr[1]]
    # print new_arr
  # else
  end
  print new_arr
  puts ""
  new_arr
end

def combine_arr(arr)
  new_arr = []
  arr.map do |el|
    unless el.map(&:class).all? { |c| c != Array }
      combine_arr(el)
    end
  end
  # .all?(true) do
    case arr[0] <=> arr[1]
    when 1
      new_arr += [arr[1] + arr[0]]
      # print new_arr
    when -1 || 0
      new_arr += [arr[0] + arr[1]]
      # print new_arr
    # else
    end
  # end
  print new_arr
  puts ""
  new_arr
end

# [[[[[[7], [3]], [9]], [[15], [23]]], [[[1], [6]], [[51], [22]]]],
#  [[[[37], [54]], [[43], [5]]], [[[25], [35]], [[18], [46]]]]] 
def combine_arr(arr)
  new_arr = []
  # print arr
  # puts ""
  if arr.class == Array && arr.dig(0).class == Array && arr.dig(0, 0).class != Array
    # el.map { |i| i.dig(0, 0) }.class != Array
    print arr
    puts ""
    case arr[0] <=> arr[1]
    when 1
      new_arr += [arr[1] + arr[0]]
    when -1 || 0
      new_arr += [arr[0] + arr[1]]
    end
    # print el
    # puts ""
    # print el.map{ |i| i }
    # puts ""
    # print el.map { |i| i.map { |z| z.class }.all? { |c| c != Array } }
    # puts ""

    print new_arr
    puts ""
  elsif arr.class == Array && arr.dig(0).class == Array && arr.dig(0, 0).class == Array
    arr.map do |el|
      # el.map do |i|
        new_arr = combine_arr(el)
      # end
    end
  else
    new_arr = arr
  end
  # arr.map do |el|
  #   # unless el.map(&:class).all? { |c| c != Array }
  #   # print el.map { |i| i.map { |z| z.class }.all? { |c| c != Array } }
  #   # puts
  #   # print el.map { |i| i.map { |z| z.class }}
  #   # print el.dig(0,0).class 
  #   # != Array
  #   print el
  #   puts ""
  #   unless el.class == Array && el.dig(0).class != Array
  #     # el.map { |i| i.dig(0, 0) }.class != Array
  #     combine_arr(el)
  #     # print el
  #     # puts ""
  #     # print el.map{ |i| i }
  #     # puts ""
  #     # print el.map { |i| i.map { |z| z.class }.all? { |c| c != Array } }
  #     # puts ""
  #   end
    
    # print el.map(&:class)
    # puts ""
    # case arr[0] <=> arr[1]
    # when 1
    #   new_arr += [arr[1] + arr[0]]
    # when -1 || 0
    #   new_arr += [arr[0] + arr[1]]
    # end
    # print el
    # puts ""
  # end

  new_arr
end

def combine_arr(arr)
  new_arr = []
  # print arr
  # puts ""
  go_deeper = false
  arr.map do |el|
    # print el.class
    # puts ""
    if el.class == Array && el.map(&:class).all? { |c| c == Array }
      el.map do |i|
        unless i.map(&:class).all? { |c| c != Array }
          # combine_arr(el)
          go_deeper = true
        end
      end
      unless go_deeper
        # case el[0] <=> el[1]
        # when 1
        #   new_arr += [el[1] + el[0]]
        # when -1 || 0
        #   new_arr += [el[0] + el[1]]
        # end
        # print el
        # puts ""
      end
    end
    if go_deeper
      combine_arr(el)
      go_deeper = false
    else
      case el[0] <=> el[1]
      when 1
        new_arr += [el[1] + el[0]]
      when -1 || 0
        new_arr += [el[0] + el[1]]
      end
    #   print el
    #   puts ""
    end
  end
  print new_arr
  puts ""
  new_arr
end

def combine_arr(arr)
  new_arr = []
  # arr.map
  (0..1).each do |i|
    
    if arr[i].map(&:class).all? { |c| c != Array }
      # print arr
      print arr[i]
      puts ""
      # print el
      # puts ""
      case arr[0] <=> arr[1]
      when 1
        new_arr += [arr[1] + arr[0]]
      when -1 || 0
        new_arr += [arr[0] + arr[1]]
      end
    else  
      new_arr = combine_arr(arr[i])
    end
  end

  # case arr[0] <=> arr[1]
  # when 1
  #   new_arr += [arr[1] + arr[0]]
  # when -1 || 0
  #   new_arr += [arr[0] + arr[1]]
  # end
  # print new_arr
  # puts ""
  new_arr
end

def merge_sort(arr)
  divided_arr = divide_arr(arr)
  combine_arr(arr)
end

p merge_sort([9, 5, 7, 1])
# == [1, 5, 7, 9]
p merge_sort([5, 3]) == [3, 5]
p merge_sort([6, 2, 7, 1, 4]) == [1, 2, 4, 6, 7]
p merge_sort(%w(Sue Pete Alice Tyler Rachel Kim Bonnie)) == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)
p merge_sort([7, 3, 9, 15, 23, 1, 6, 51, 22, 37, 54, 43, 5, 25, 35, 18, 46]) == [1, 3, 5, 6, 7, 9, 15, 18, 22, 23, 25, 35, 37, 43, 46, 51, 54]

# unless every array item is lesser than the one to the left of it, re-sort