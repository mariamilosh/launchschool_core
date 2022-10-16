def oddities(arr)
  odd_arr = []
  arr.each_with_index do |val, i|
    odd_arr << val if (i+1).odd?
  end
  odd_arr
end

def evens(arr)
  even_arr = []
  arr.each_with_index do |val, i|
    even_arr << val if i.odd?
  end
  even_arr
end

def oddities_v2(arr)
  i = 0
  odd_arr = []
  while i < arr.size do
    odd_arr << arr[i] if i % 2 == 0
    i += 1
  end
  odd_arr
end

def oddities_v3(arr)
  arr.select do |num|
    arr.find_index(num) % 2 == 0
  end
end

# puts oddities([2, 3, 4, 5, 6]) == [2, 4, 6]
# puts oddities([1, 2, 3, 4, 5, 6]) == [1, 3, 5]
# puts oddities(['abc', 'def']) == ['abc']
# puts oddities([123]) == [123]
# puts oddities([]) == []
#
# puts evens([2, 3, 4, 5, 6]) == [3, 5]
puts oddities_v3([2, 3, 4, 5, 6]) == [2, 4, 6]
puts oddities_v3([1, 2, 3, 4, 5, 6]) == [1, 3, 5]
puts oddities_v3(['abc', 'def']) == ['abc']
puts oddities_v3([123]) == [123]
puts oddities_v3([]) == []
